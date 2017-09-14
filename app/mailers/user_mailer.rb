class UserMailer < ApplicationMailer
  #default from: "Admin <admin@ready-text.com>"
  default from: ENV['GMAIL_USERNAME']
  # layout 'mailer'

  def test_email(sender,recipent)
    mail(from: sender,to: recipent, subject: 'Test Email')
  end

  def subscription_auto_email(user,subscription)
    @user = user
    @subscription = subscription
    sub = subscription.trial? ? "trial7352" : (subscription.walkin? ? "paid9922" : "marketing7222")
    mail(from: @user.email,to: ENV['HELLO_EMAIL'],subject: sub)
  end

  def non_subscriber_email(user)
    @user = user
    sub = "nonconvert7333"
    mail(to: ENV['HELLO_EMAIL'],subject: sub)
  end

end