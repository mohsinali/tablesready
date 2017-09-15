class PagesController < ApplicationController
  skip_before_action :check_subscription  
  def pricing
    @walkin_plans = Plan.walkin
    @marketing_plans = Plan.marketing
  end

  def support
    if request.post?
      UserMailer.support_email(params[:name],params[:email],params[:body]).deliver
      redirect_to root_path,notice: "Thanks for your feedback." and return
    end
  end

  def search_results
  end

  def lockscreen
    render :layout => "empty"
  end

  def invoice
  end

  def invoice_print
    render :layout => "empty"
  end

  def login
    render :layout => "empty"
  end

  def login_2
    render :layout => "empty"
  end

  def register
    render :layout => "empty"
  end

  def internal_server_error
    render :layout => "empty"
  end

  def empty_page
  end

  def not_found_error
    render :layout => "empty"
  end

end
