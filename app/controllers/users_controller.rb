class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @comments = Comment.where(user_id: @user.id)
    @points = 0
    @comments.each{ |c| @points += (c.upvotes.size - c.downvotes.size) }
    @num_votes = @comments.size
    @points -= @num_votes
  end
end
