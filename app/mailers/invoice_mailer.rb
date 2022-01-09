class InvoiceMailer < ApplicationMailer
  default template_path: 'mailers/invoice_mailer'

  def send_to_admin(name: nil, email:, artwork_title:, invoice:)
    attachments.inline['invoice.pdf'] = pdf_file(invoice)
    mail(
      reply_to: reply_to_acquirer(name, email),
      subject: "Artwork Order Request [#{artwork_title}]"
    )
  end

  def send_to_acquirer(name: nil, email:, artwork_title:, invoice:)
    attachments.inline['invoice.pdf'] = pdf_file(invoice)
    mail(
      from: email_address_with_name('pinktankcollective@gmail.com', 'Pink Tank Collective'),
      to: to_acquirer(name, email),
      subject: "Artwork Order Request [#{artwork_title}]"
    ) 
  end

  private

  def reply_to_acquirer(name, email)
    name.present? ? email_address_with_name(email, name) : email
  end

  def to_acquirer(name, email)
    name.present? ? email_address_with_name(email, name) : email
  end

  def pdf_file(invoice)
    io = StringIO.new(invoice.render)
    Tempfile.open(['invoice', '.pdf'], encoding: 'ascii-8bit') do |f|
      f.puts(io.read)
    end
  end
end
