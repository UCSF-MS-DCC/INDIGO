class AdminMailer < ApplicationMailer
  default from: 'indigoprojectwebmaster@gmail.com'

  def new_user_welcome_message(user)
    @user = user
    mail(to: @user.email, subject: 'INDIGO: Site registration')
  end
end
