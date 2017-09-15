class UserMailer < ApplicationMailer
  default from: ENV['HELLO_EMAIL']
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

  def subscription_cancel_email(user,plan)
    @user = user
    @plan = plan
    sub = "cancel911"
    mail(from: @user.email,to: ENV['HELLO_EMAIL'],subject: sub)
  end

  def non_subscriber_email(user)
    @user = user
    sub = "nonconvert7333"
    mail(to: ENV['HELLO_EMAIL'],subject: sub)
  end

  def abandoment_email(user)
    @user = user
    sub = "abandon123"
    mail(from: @user.email,to: ENV['HELLO_EMAIL'],subject: sub)
  end

  def support_email(name,email,body)
    @name = name
    @email = email
    @body = body
    mail(to: ENV['HELLO_EMAIL'],subject: "Support")
  end

end