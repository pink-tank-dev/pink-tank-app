class InvoiceMailer < ApplicationMailer
  default template_path: 'mailers/invoice_mailer'

  def send_to_admin(name: nil, email:, artwork:, invoice:)
    @artwork = artwork
    attachments['invoice.pdf'] = invoice.render
    mail(
      reply_to: reply_to_acquirer(name, email),
      subject: "Artwork Order Request [#{artwork.title}]"
    )
  end

  def send_to_acquirer(name: nil, email:, artwork:, invoice:)
    @artwork = artwork
    attachments['invoice.pdf'] = invoice.render
    mail(
      from: email_address_with_name('pinktankcollective@gmail.com', 'Pink Tank Collective'),
      to: to_acquirer(name, email),
      subject: "Artwork Order Request [#{artwork.title}]"
    ) 
  end

  private

  def reply_to_acquirer(name, email)
    name.present? ? email_address_with_name(email, name) : email
  end

  def to_acquirer(name, email)
    name.present? ? email_address_with_name(email, name) : email
  end
end
