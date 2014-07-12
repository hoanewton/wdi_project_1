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
      redirect_to post_path(@comment.post)
    else
      render :edit
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    post = @comment.post
    @comment.destroy
    flash[:notice] = "Comment deleted!"
    redirect_to post_path(post)
  end

  private
  def comment_params
    params.require(:comment).permit(:content)
  end

  def comment_authorization
    @comment = Comment.find(params[:id])
    if current_user != @comment.user && !current_user.admin?
      flash[:notice] = "You're not authorized for that action!"
      redirect_to post_path(@comment.post)
    end 
  end

end