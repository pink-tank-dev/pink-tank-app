class UsersMailer < ApplicationMailer
  before_action :set_user
  default reply_to: 'pinktankcollective@gmail.com'
  default template_path: 'mailers/users_mailer'

  def send_welcome_email(temporary_password:)
    @temporary_password = temporary_password
    
    mail(to: email_address_with_name(@user.email, @user.name),
         subject: 'Welcome to Pink Tank!',
         template_name: 'welcome_email')
  end

  def send_reset_password_email(temporary_password:)
    @temporary_password = temporary_password
    
    mail(to: email_address_with_name(@user.email, @user.name),
         subject: 'Pssst! Pink Tank here with your reset password.',
         template_name: 'reset_password_email')
  end

  private

  def set_user
    @user = User.find_by(id: params[:user_id])
    return unless @user && @user.email.present?
  end
end
