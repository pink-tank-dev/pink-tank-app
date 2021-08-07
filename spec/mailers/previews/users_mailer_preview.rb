class UsersMailerPreview < ActionMailer::Preview
  def send_welcome_email
    user = User.first
    temporary_password = SecureRandom.hex(10)
    UsersMailer.with(user_id: user.id)
               .send_welcome_email(temporary_password: temporary_password)
  end

  def send_reset_password_email
    user = User.first
    temporary_password = SecureRandom.hex(10)
    UsersMailer.with(user_id: user.id)
               .send_reset_password_email(temporary_password: temporary_password)
  end
end
