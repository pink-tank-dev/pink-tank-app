module ArtistModule
  class PostsController < ApplicationController
    include ActiveStorage::SetCurrent
    before_action :set_post, only: %i[edit update show]
    PUBLISH = "Publish".freeze
    UNPUBLISH = "Unpublish".freeze

    def new
      @post = Post.new
    end

    def create
      @post = Post.new(post_params.merge(artist_id: current_artist.id))

      @post.assign_attributes(status: :published, published_at: Time.current) if publishing?

      if @post.save
        _path = @post.draft? ? artist_module_post_path(@post) : artist_module_profile_path
        message = @post.draft? ? "created" : "published"
        redirect_to _path, success: "#{@post.title} successfully #{message}."
      else
        flash[:danger] = post_errors
        render :new
      end
    end

    def edit; end
    
    def update
      if unpublishing?
        @post.assign_attributes(status: :draft)
      else
        @post.assign_attributes(post_params)
        if publishing?
          if @post.published_at.present?
            @post.assign_attributes(status: :published)
          else
            @post.assign_attributes(status: :published, published_at: Time.current)
          end
        end
        
      end

      if @post.valid?
        @post.save
        _path = @post.draft? ? edit_or_show? : artist_module_profile_path
        message = @post.draft? ? "updated" : "published"
        redirect_to _path, success: "#{@post.title} successfully #{message}."
      else
        flash[:danger] = post_errors
        render :edit
      end
    end

    def show; end

    private

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

    def edit_or_show?
      if @post.saved_changes[:status]&.first == "published" && @post.saved_changes[:status]&.second == "draft"
        edit_artist_module_post_path(@post)
      else
        artist_module_post_path(@post)
      end
    end
  end
end
