class CommentsController < ApplicationController

	before_action :comment_authorization, only: [:edit, :update, :destroy]
  before_action :authenticate, only: [:new, :create]

	def index
		@comments = Comment.all
	end

	def new
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      post = Post.find(params[:post_id])
      post.comments << @comment
      current_user.comments << @comment
      redirect_to post_path(post)
    else
      redirect_to posts_path
    end
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      redirect_to comments_path
    else
      render :edit
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    session[:current_user] = nil
    redirect_to comments_path
  end

  private
  def comment_params
    params.require(:comment).permit(:content)
  end

  def comment_authorization
    unless current_user == Comment.find(params[:id]).user
      redirect_to posts_path
    end 
  end

end