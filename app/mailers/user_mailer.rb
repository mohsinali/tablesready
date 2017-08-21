class UserMailer < ApplicationMailer
  default from: "Admin <admin@ready-text.com>"
  # layout 'mailer'

  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: @subject)
  end

end