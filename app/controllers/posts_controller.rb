class PostsController < ApplicationController
  before_action :set_artist

  def index
    redirect_to artists_path, warning: "Artist not found." unless @artist.present?
    @posts = @artist.posts
  end

  private

  def set_artist
    @artist = Artist.find_by(id: params[:artist_id])
  end
end