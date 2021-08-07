class ArtistsMailerPreview < ActionMailer::Preview
  def send_welcome_email
    artist = Artist.first
    temporary_password = SecureRandom.hex(10)
    ArtistsMailer.with(artist_id: artist.id).send_welcome_email(temporary_password: temporary_password)
  end

  def send_reset_password_email
    artist = Artist.first
    temporary_password = SecureRandom.hex(10)
    ArtistsMailer.with(artist_id: artist.id).send_reset_password_email(temporary_password: temporary_password)
  end
end
