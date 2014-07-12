class VotesController < ApplicationController

	before_action :vote_authorization, only: [:create, :update]
  before_action :authenticate, only: [:new, :create]

	def create
		if params[:commit] == "Vote Up" 
			vote_score = 1 
		elsif params[:commit] == "Vote Down"
			vote_score = -1
		else
			# throw an exception
			raise 'Received an invalid vote type'
		end

		@vote = Vote.create!(
			user_id: session[:current_user],
			comment_id: params[:comment_id],
			number: vote_score
		)
		redirect_to post_path(@vote.comment.post)
	end

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
    unless current_user != Comment.find(params[:comment_id]).user
      redirect_to post_path(Comment.find(params[:comment_id]).post)
    end 
  end

end