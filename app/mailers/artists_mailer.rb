class ArtistsMailer < ApplicationMailer
  before_action :set_artist
  default reply_to: 'pinktankcollective@gmail.com'
  default template_path: 'mailers/artists_mailer'

  def send_welcome_email(temporary_password:)
    @temporary_password = temporary_password
    
    mail(to: email_address_with_name(@artist.email, @artist.name),
         subject: 'Welcome to Pink Tank!',
         template_name: 'welcome_email')
  end

  def send_reset_password_email(temporary_password:)
    @temporary_password = temporary_password

    mail(to: email_address_with_name(@artist.email, @artist.name),
         subject: 'Pssst! Pink Tank here with your reset password.',
         template_name: 'reset_password_email')
  end

  private

  def set_artist
    @artist = Artist.find_by(id: params[:artist_id])
    return unless @artist && @artist.email.present?
  end
end
