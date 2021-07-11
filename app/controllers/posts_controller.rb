class PostsController < ApplicationController
  before_action :set_artist
  before_action :set_post, only: %i[edit update show]

  PUBLISH = "Publish".freeze
  UNPUBLISH = "Unpublish".freeze

  def index
    redirect_to artists_path, warning: "Artist not found." unless @artist.present?
    @posts = @artist.posts.with_rich_text_body.order(created_at: :asc)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params.merge(artist_id: @artist.id))

    @post.assign_attributes(status: :published, published_at: Time.current) if publishing?

    if @post.save
      path = @post.draft? ? artist_post_path(@artist, @post) : artist_posts_path(@artist)
      message = @post.draft? ? "created" : "published"
      redirect_to path, success: "#{@post.title} successfully #{message}."
    else
      flash[:danger] = post_errors
      render :new
    end
  end

  def edit; end
  
  def update
    if unpublishing?
      @post.assign_attributes(status: :draft, published_at: nil)
    else
      @post.assign_attributes(post_params)
      @post.assign_attributes(status: :published, published_at: Time.current) if publishing?
    end

    if @post.save
      path = @post.draft? ? artist_post_path(@artist, @post) : artist_posts_path(@artist)
      message = @post.draft? ? "updated" : "published"
      redirect_to path, success: "#{@post.title} successfully #{message}."
    else
      flash[:danger] = post_errors
      render :edit
    end
  end

  def show; end

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