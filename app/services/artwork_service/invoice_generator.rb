module ArtworkService
  class InvoiceGenerator
    include MoneyRails::ActionViewExtension

    SHIPPING = 'shipping'.freeze
    INSTALLMENTS = 'installments'.freeze
    ORDER_IN_PROCESS = 'ORDER IN PROCESS'.freeze
    PAID = 'PAID'.freeze

    def initialize(acquire_params)
      @acquire_params = acquire_params
      @delivery_method = @acquire_params[:delivery_method]
      @payment_method = @acquire_params[:payment_method]
    end

    def run
      Receipts::Invoice.new(
        id: invoice_id,
        issue_date: Date.current,
        due_date: due_date,
        status: status,
        bill_to: bill_to,
        company: company,
        line_items: line_items
      )
    end

    private

    attr_reader :acquire_params, :delivery_method, :payment_method

    def artwork
      @artwork ||= Artwork.find_by(id: acquire_params[:artwork_id])
    end

    def shipping?
      delivery_method == SHIPPING
    end

    def installments?
      payment_method == INSTALLMENTS
    end

    def invoice_id
      "PT-#{DateTime.current.strftime('%Y%m%d-%H%M%S%L')}-#{artwork.id}"
    end

    def due_date
      installments? ? 3.months.from_now.to_date : 1.month.from_now.to_date
    end

    def status
      installments? ?  ORDER_IN_PROCESS : PAID
    end

    def bill_to
      if shipping?
        [
          acquire_params[:name],
          "#{acquire_params[:address_1]} #{acquire_params[:address_2]}",
          "#{acquire_params[:city]}",
          "#{acquire_params[:postal_code]} #{acquire_params[:state]}",
          acquire_params[:country],
          nil,
          acquire_params[:email],
          acquire_params[:phone]
        ]
      else
        [
          acquire_params[:email],
          acquire_params[:phone]
        ]
      end
    end

    def company
      {
        name: 'Pink Tank Collective',
        email: 'pinktankcollective@gmail.com',
        logo: Rails.root.join('app/assets/images/logo_pinktank_transparent.png')
      }
    end

    def payment_term
      installments? ? 'Installment 3 months' : 1.month.from_now.to_date
    end

    def line_items
      [
        ["<b>Item</b>", "<b>Unit Cost</b>", "<b>Quantity</b>", "<b>Payment Term</b>", "<b>Amount</b>"],
        [artwork.title, humanized_money_with_symbol(artwork.price), 1.to_s, payment_term, humanized_money_with_symbol(artwork.price)],
        [nil, nil, "Subtotal", nil, humanized_money_with_symbol(artwork.price)],
        [nil, nil, "Total", nil, humanized_money_with_symbol(artwork.price)],
      ]
    end
  end
end
