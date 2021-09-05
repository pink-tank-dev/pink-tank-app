module Admin
  class ArtistsController < ApplicationController
    before_action :set_artist, except: %i[index new create]

    def index
      artists = ArtistPresenter.from_list(Artist.all.order(id: :asc))
      @artists = Kaminari.paginate_array(artists)
                         .page(params[:page])
                         .per(10)
    end

    def new
      @artist = Artist.new
    end

    def create
      @artist = Artist.new(artist_params.merge(password: temporary_password))
      if @artist.save
        redirect_to admin_artist_path(@artist), success: "#{@artist.name} successfully created."
      else
        flash[:danger] = artist_errors
        render :new
      end
    end

    def edit
      redirect_to admin_artists_path, warning: "Artist not found." unless @artist.present?
    end
    
    def update
      @artist.assign_attributes(artist_params)
      if @artist.save
        redirect_to admin_artist_path(@artist), success: "#{@artist.name} successfully updated."
      else
        flash[:danger] = artist_errors
        render :edit
      end
    end

    def show
      redirect_to admin_artists_path, warning: "Artist not found." unless @artist.present?
      @artist = ArtistPresenter.new(@artist)
    end

    def reset_password
      @artist.update(password: temporary_password)
      artists_mailer.send_reset_password_email(temporary_password: temporary_password)
                    .deliver_later
    end

    def send_welcome_email
      @artist.update(password: temporary_password)
      artists_mailer.send_welcome_email(temporary_password: temporary_password)
                    .deliver_later
    end

    private

    def set_artist
      @artist = Artist.find_by(id: params[:id])
    end

    def artist_params
      params.require(:artist).permit(
        :avatar,
        :name,
        :email,
        :instagram,
        :about,
        :statement,
        :status,
        social_media_attributes: [
          :id,
          :medium,
          :handle,
          :_destroy
        ])
    end

    def temporary_password
      @temporary_password ||= SecureRandom.hex(10)
    end

    def artists_mailer
      ArtistsMailer.with(artist_id: @artist.id)
    end

    def artist_errors
      @artist.errors.full_messages.join(', ')
    end
  end
end
