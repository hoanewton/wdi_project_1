class VotesController < ApplicationController

	before_action :vote_authorization, only: [:create, :update]
  before_action :authenticate, only: [:new, :create]

	def create
		@vote = Vote.create(
			user_id: session[:current_user],
			comment_id: params[:comment_id],
			number: 1
			)
		redirect_to post_path(@vote.comment.post)
	end

	# def create
 #    @vote = Vote.create(
	# 		user_id: session[:current_user].user_id
	# 		comment_id: Comment.find(params[:id])
	# 		number: 1
	# 		)
 #    # if @vote
 #    # 	post = Post.find(params[:id])
 #    #   comment = Comment.find(params[:comment_id])
 #    #   comment.votes << @vote
 #    #   current_user.votes << @vote
 #      redirect_to post_path(@post)
 #    # end
 #  end

	def update
    @vote = Vote.find(params[:id])
    if @vote.update(vote_params)
      redirect_to post_path(post)
    else
      render :edit
    end
  end

  private

  def vote_authorization
    unless current_user == Comment.find(params[:comment_id]).user
      redirect_to post_path(Comment.find(params[:comment_id]).post)
    end 
  end

end