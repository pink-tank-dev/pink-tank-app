module Admin
  class ArtworksController < Admin::ApplicationController
    include MoneyRails::ActionViewExtension
    before_action :set_artist
    before_action :set_artwork, except: %i[index new create]

    def new
      @artwork = Artwork.new
    end

    def create
      @artwork = Artwork.new(artwork_params.merge(artist: @artist))
      if @artwork.save
        redirect_to admin_artist_artwork_path(@artist, @artwork), success: "Artwork successfully created."
      else
        flash[:danger] = artwork_errors
        render :new
      end
    end

    def edit; end

    def update
      @artwork.assign_attributes(artwork_params)
      if @artwork.save
        redirect_to admin_artist_artwork_path(@artist, @artwork), success: "Artwork successfully updated."
      else
        flash[:danger] = artwork_errors
        render :edit
      end
    end

    def show; end

    def invoice_preview
      @invoice_preview = Receipts::Invoice.new(
        id: "PT-#{DateTime.current.strftime('%Y%m%d-%H%M%S%L')}-#{@artwork.id}",
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
          [@artwork.title, humanized_money_with_symbol(@artwork.price), 1.to_s, 'Installment 3 months', humanized_money_with_symbol(@artwork.price)],
          [nil, nil, "Subtotal", nil, humanized_money_with_symbol(@artwork.price)],
          [nil, nil, "Total", nil, humanized_money_with_symbol(@artwork.price)],
        ]
      )

      respond_to do |format|
        format.pdf {
          send_data(
            @invoice_preview.render,
            filename: "#{@artwork.title}}_invoice_preview.pdf",
            type: 'application/pdf',
            disposition: :inline
          )
        }
      end
    end

    def destroy
      series = Series.by_artwork(@artwork.id)
      if series.present?
        @artwork.errors.add(:base, "Artwork connected to series. Remove the artwork from #{series.pluck(:title).join(', ')} before attempting deletion.")
        redirect_to admin_artist_path(@artist), danger: artwork_errors
      else
        @artwork.destroy
        redirect_to admin_artist_path(@artist), success: "Artwork successfully deleted"
      end
    end

    private

    def set_artist
      @artist = Artist.friendly.find(params[:artist_id])
    rescue ActiveRecord::RecordNotFound
      redirect_to admin_artists_path, warning: "Artist not found."
    end

    def set_artwork
      @artwork = @artist.artworks.find_by(id: params[:id])
      redirect_to admin_artist_path(@artist), warning: "Artwork not found." unless @artwork.present?
    end

    def artwork_params
      params.require(:artwork).permit(
        :file,
        :title,
        :medium,
        :measurements,
        :description,
        :status,
        :notes,
        :price,
        :nft_site_url
      )
    end

    def artwork_errors
      @artwork.errors.full_messages.join(', ')
    end
  end
end
