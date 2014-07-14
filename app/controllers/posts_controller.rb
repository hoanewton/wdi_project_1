class PostsController < ApplicationController

	before_action :authenticate, only: [:new, :create]
	before_action :post_authorization, only: [:edit, :update, :destroy]

	def index
		@posts = Post.all
	end

	def new
    @post = Post.new
  end

  def show
  	@post = Post.find(params[:id])
    @comments = @post.comments
    @comment = Comment.new
    # @user = @post.user 
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = session[:current_user]
    if @post.save
      redirect_to posts_path
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to posts_path
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  def my_posts
    @posts = Post.where(user_id: current_user.id)
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end

  def post_authorization
    unless current_user == Post.find(params[:id]).user
      redirect_to posts_path
    end 
  end

end