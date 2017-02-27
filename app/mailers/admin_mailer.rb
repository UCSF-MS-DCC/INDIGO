class AdminMailer < ApplicationMailer
  default from: 'indigoprojectwebmaster@gmail.com'

  def new_user_welcome_message(user)
    @user = user
    mail(to: @user.email, subject: 'INDIGO: Site registration')
  end

  def new_user_admin_alert(user)
    @user = user
    mail(to:'adam.renschen@ucsf.edu', subject: @user.email+' has signed up for an Indigo account')
  end

  def new_user_approved_notification(user)
    @user = user
    mail(to: @user.email, subject: 'INDIGO: Your account has been approved')
  end
end
