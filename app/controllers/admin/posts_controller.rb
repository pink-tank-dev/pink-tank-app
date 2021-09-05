module Admin
  class PostsController < ApplicationController
    include ActiveStorage::SetCurrent
    before_action :set_artist
    before_action :set_post, only: %i[show unpublish]
    PUBLISH = "Publish".freeze
    UNPUBLISH = "Unpublish".freeze

    def index
      redirect_to admin_artists_path, warning: "Artist not found." unless @artist.present?

      @posts = if @artist.present?
                 @artist.posts.with_rich_text_body_and_embeds.order(created_at: :asc)
               else
                 nil
               end
    end

    def show
      redirect_to admin_artist_posts_path(@artist.id), warning: "Post not found." unless @post.present?
    end

    private

    def set_artist
      @artist = Artist.find_by(id: params[:artist_id])
    end

    def set_post
      @post = Post.find_by(id: params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :body, :status)
    end

    def post_errors
      @post.errors.full_messages.join(', ')
    end

    def publishing?
      params[:commit] == PUBLISH
    end

    def unpublishing?
      params[:commit] == UNPUBLISH
    end
  end
end
