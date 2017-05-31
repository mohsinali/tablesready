require 'stripe_box'
class SubscriptionsController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :check_subscription
  include StripeBox

  def index
    @walkin_subscriptions = current_user.subscriptions.walkin
    @marketing_subscriptions = current_user.subscriptions.marketing
  end

  def new
    @subcription = Subscription.new
    @plan = Plan.find_by(stripe_id: 'basic')
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
    plan = (params[:plan_id].blank? ? Plan.find_by(stripe_id: 'basic') : Plan.find(params[:plan_id]))
    begin
      response = current_user.subscribe(plan.stripe_id)
    rescue Exception => e
      response = {error: true, message: e.message}
    end
    render json: response
  end

  def destroy
    @subcription = Subscription.find(params[:id])
    response = cancel_subscription(@subcription.stripe_id)
    if response[:error]
      msg = response[:message]
    else
      @subcription.destroy
      msg = "You are unsubscribed successfully!"
    end
    redirect_to subscriptions_path, notice: msg
  end
end
