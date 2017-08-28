class UserMailer < ApplicationMailer
  #default from: "Admin <admin@ready-text.com>"
  default from: ENV['GMAIL_USERNAME']
  # layout 'mailer'

  def test_email(email_address)
    mail(to: email_address, subject: @subject)
  end

  def subscription_auto_email(user,in_trial)
    @user = user
    sub = in_trial ? "trial7352" : "paid9922"
    mail(to: ENV['HELLO_EMAIL'],subject: sub)
  end

  def non_subscriber_email(user)
    @user = user
    sub = "nonconvert7333"
    mail(to: ENV['HELLO_EMAIL'],subject: sub)
  end

end