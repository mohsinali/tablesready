namespace :schedulable do
  desc "Notifiy Admin about users, whose trial is ended."
  task no_subscription_email: :environment do
    users = User.in_trial.where("trial_ends_at < ? ",Time.now)
    puts "Email will be sent to: #{users.size} users."
    users.each do |user|
      user.no_subscription_email
    end
  end
end