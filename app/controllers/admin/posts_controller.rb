module Admin
  class PostsController < ApplicationController
    include ActiveStorage::SetCurrent
    before_action :set_artist

    def index
      @posts = if @artist.present?
                 @artist.posts.with_rich_text_body_and_embeds.order(created_at: :asc)
               else
                 nil
               end
    end

    def show
      @post = Post.find_by(id: params[:id])

      redirect_to admin_artist_posts_path(@artist.id), warning: "Post not found." unless @post.present?
    end

    private

    def set_artist
      @artist = Artist.friendly.find(params[:artist_id])
    rescue ActiveRecord::RecordNotFound
      redirect_to admin_artists_path, warning: "Artist not found."
    end
  end
end
