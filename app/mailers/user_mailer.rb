class UserMailer < ApplicationMailer
  # default from: "Admin <admin@ready-text.com>"
  # layout 'mailer'

  def test_email(user)
    @user = user
    mail(to: @user.email, subject: @subject)
  end

  def subscription_auto_email(user,in_trial)
    @user = user
    sub = in_trial ? "trial7352" : "paid9922"
    mail(to: @user.email,subject: sub)
  end

end