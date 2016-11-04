class UserMailer < ApplicationMailer
  default from: 'indigoprojectwebmaster@gmail.com'

  def welcome_message(user)
    @user = user
    mail(to: @user.email, subject: 'Testing the Sign Up Mailer')
  end
end
