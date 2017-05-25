module ApplicationHelper
    def is_active_controller(controller_name)
      params[:controller] == controller_name ? "active" : nil
    end

    def is_active_action(action_name)
      params[:action] == action_name ? "active" : nil
    end

    def main_subscription_link
      if current_user and current_user.in_trial
        info = <<-INFO
          <div class="alert alert-info">
            <strong> You are using trial account: </strong>
            You trial #{current_user.trial_expired? ?  'has been exprired' : 'will exprire'} on #{current_user.trial_ends_at.to_date},
            #{link_to "Click here",new_subscription_path} to buy subscription.
          </div>
        INFO
        info.html_safe
      end
    end
end
