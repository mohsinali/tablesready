require 'stripe_box'
class SubscriptionsController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :check_subscription
  include StripeBox

  def index
    @is_trial = false
    @walkin_subscriptions = current_user.subscriptions.walkin
    if @walkin_subscriptions.empty?
      @walkin_subscriptions = current_user.subscriptions.trial
      @is_trial = true
    end
    @marketing_subscriptions = current_user.subscriptions.marketing
  end

  def new
    @subcription = Subscription.new
    @plan = (params[:plan_id].blank? ? Plan.find_by(stripe_id: 'basic') : Plan.find_by(stripe_id: params[:plan_id]))
  end

  def create_customer
    ## If user doesn't have stripe customer id, then create a new customer at stripe
    ## This will also create a card at stripe
    params[:email] = current_user.email
    if current_user.stripe_customer_id.blank?
      response = create_stripe_customer(current_user,params)
      unless response[:error]
        customer = response[:customer]
        params[:customer_id] = customer.id
        current_user.update_attribute(:stripe_customer_id, customer.id)
        response = { error: false, message: "You have been registered successfully at the payment gateway." }
      end
    else
      ## If user has stripe_customer_id then just create a card using the token
      ## After creating the card make it default card
      params[:customer_id] = current_user.stripe_customer_id
      response = create_card(params[:customer_id],params[:stripeToken])
      if response[:error]
        response = { error: true, message: response[:message] }
      else
        response = { error: false, message: "Your card is updated  successfully." }
      end
    end

    return render json: response
  end

  def create
    get_plans
    @plan = (params[:plan_id].blank? ? Plan.find_by(stripe_id: 'basic') : Plan.find(params[:plan_id]))
    begin
      @response = current_user.subscribe(@plan.stripe_id,@plan.plan_type.downcase)
    rescue Exception => e
      @response = {error: true, message: e.message}
    end
    if params[:source].blank?
      flash[:notice] = @response[:message]
      render json: @response
      return
    else
      respond_to do |format|
        format.js {render layout: false}
      end
    end
  end

  def update
    get_plans
    @plan = (params[:plan_id].blank? ? Plan.find_by(stripe_id: 'basic') : Plan.find(params[:plan_id]))
    begin
      @response = current_user.subscribe(@plan.stripe_id,@plan.plan_type.downcase)
    rescue Exception => e
      @response = {error: true, message: e.message}
    end
    respond_to do |format|
      format.js {render layout: false}
    end
  end

  def destroy
    @subscription = Subscription.find(params[:id])
    @plan = @subscription.plan
    response = cancel_subscription(@subscription.stripe_id)
    if response[:error]
      msg = response[:message]
    else
      @subscription.destroy
      msg = "Your #{@plan.walkin? ? 'subcription' : 'addon'} has been cancelled!"
    end
    redirect_to subscriptions_path, notice: msg
  end

  def extend_trial
    @subscription = Subscription.find(params[:id])
    if current_user and !current_user.trial_extended
      current_user.update(trial_extended: true,trial_ends_at: current_user.trial_ends_at + ENV['TRIAL_EXTENDABLE_DAYS'].to_i.days)
      @subscription.update(expired_at: current_user.trial_ends_at)
      redirect_to root_path,notice: "Your trial is extended upto #{current_user.trial_ends_at.to_date}"
    else
      redirect_to "/pricing"
    end
  end

  private

  def current_plan plan_type
    plan = nil
    current_subscription = current_user.current_subscription(plan_type.downcase)
    if current_subscription.present?
      plan = current_subscription.plan
    end
    plan
  end

  def get_plans
    @walkin_plans = Plan.walkin
    @marketing_plans = Plan.marketing
  end
end
