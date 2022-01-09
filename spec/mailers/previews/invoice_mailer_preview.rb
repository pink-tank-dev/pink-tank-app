class InvoiceMailerPreview < ActionMailer::Preview
  def send_to_admin
    InvoiceMailer.send_to_admin(
      name: 'Nazrin',
      email: 'nazrin@mail.com',
      artwork: artwork,
      invoice: invoice
    )
  end

  def send_to_acquirer
    InvoiceMailer.send_to_acquirer(
      name: 'Nazrin',
      email: 'nazrin@mail.com',
      artwork: artwork,
      invoice: invoice
    )
  end

  private

  def invoice
    Receipts::Invoice.new(
        id: "PT-#{DateTime.current.strftime('%Y%m%d-%H%M%S%L')}-1",
        issue_date: Date.current,
        due_date: 3.months.from_now.to_date,
        status: 'ORDER IN PROCESS',
        bill_to: [
          Faker::Name.name,
          Faker::Address.street_address,
          Faker::Address.secondary_address,
          "#{Faker::Address.postcode Faker::Address.city}",
          Faker::Address.country,
          nil,
          Faker::Internet.email,
          Faker::PhoneNumber.phone_number
        ],
        company: {
          name: 'Pink Tank Collective',
          address: 'Kuala Lumpur',
          email: 'pinktankcollective@gmail.com',
          logo: Rails.root.join('app/assets/images/logo_pinktank_transparent.png')
        },
        line_items: [
          ["<b>Item</b>", "<b>Unit Cost</b>", "<b>Quantity</b>", "<b>Payment Term</b>", "<b>Amount</b>"],
          ['Some title', 'RM 10.00', 1.to_s, 'Installment 3 months', 'RM 10.00'],
          [nil, nil, "Subtotal", nil, 'RM 10.00'],
          [nil, nil, "Total", nil, 'RM 10.00'],
        ]
      )
  end

  def artwork
    Artwork.first
  end
end
