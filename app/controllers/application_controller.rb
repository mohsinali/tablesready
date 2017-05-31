class ApplicationController < ActionController::Base
  include ActionView::Helpers::UrlHelper
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  layout :set_layout
  before_action :check_subscription

  private

  def set_layout
    user_signed_in? ? "application" : (current_page?(root_path) ? "application" : "empty")
  end

  def check_subscription
    if current_user
      unless current_user.valid_subscription
        redirect_to new_subscription_path,notice: "Please subscribe to basic plan for using ReadyText"
      end
    end
  end
end
