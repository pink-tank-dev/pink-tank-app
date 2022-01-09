class SendAcquireInvoiceWorker
  include Sidekiq::Worker

  def perform(acquire_params)
    InvoiceMailer.send_to_admin(
      name: name,
      email: email,
      artwork: artwork,
      invoice: invoice).deliver_later
    InvoiceMailer.send_to_acquirer(
      name: name,
      email: email,
      artwork: artwork,
      invoice: invoice).deliver_later
  end

  private

  def invoice
    @invoice ||= ArtworkService::InvoiceGenerator.new(acquire_params).run
  end

  def email
    @email ||= acquire_params[:email]
  end

  def name
    @name ||= acquire_params[:name]
  end

  def artwork
    @artwork ||= Artwork.find_by(id: acquire_params[:artwork_id])
  end
end
