class SendThankYouWorker
  include Sidekiq::Worker

  def perform(name, email)
    begin
      client = MailchimpTransactional::Client.new(ENV['MAILCHIMP_TRANSACTIONAL_KEY'])
      client.messages.send_template(
        {
          template_name: 'thank-you',
          template_content: [{}],
          message: message(name, email)
        }
      )
    rescue MailchimpTransactional::ApiError => e
      Sentry.capture_exception(e)
    end
  end

  def message(name, email)
    {
      to: [
        {
          email: email
        },
        {
          name: name
        }
      ],
      track_opens: true,
      track_clicks: true,
      global_merge_vars: [
        {
          name: "FNAME",
          content: name
        }
      ]
    }
  end
end
