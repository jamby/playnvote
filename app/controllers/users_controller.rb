class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @comments = Comment.where(user_id: @user.id)
    @karma = 0
    @comments.each{ |c| @karma += (c.upvotes.size - c.downvotes.size) }
    @num_votes = @comments.size
    @karma -= @num_votes
  end
end
