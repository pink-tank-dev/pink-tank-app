module Admin
  class ArtistsController < ApplicationController
    before_action :set_artist, except: %i[index new create]

    def index
      @artists = Artist.all.order(id: :asc)
    end

    def new
      @artist = Artist.new
    end

    def create
      @artist = Artist.new(artist_params.merge(password_params))
      if @artist.save
        redirect_to admin_artist_path(@artist), success: "#{@artist.name} successfully created."
      else
        flash[:danger] = artist_errors
        render :new
      end
    end

    def edit
      redirect_to artists_path, warning: "Artist not found." unless @artist.present?
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
      redirect_to artists_path, warning: "Artist not found." unless @artist.present?
    end

    def reset_password
      @artist.update(password_params)
    end

    private

    def set_artist
      @artist = Artist.find_by(id: params[:id])
    end

    def artist_params
      params.require(:artist).permit(:avatar, :name, :email, :instagram, :about, :statement)
    end

    def password_params
      temporary_password = SecureRandom.hex(10)
      {
        password: temporary_password,
        temporary_password: temporary_password
      }
    end

    def artist_errors
      @artist.errors.full_messages.join(', ')
    end
  end
end
