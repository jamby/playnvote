class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @comments = Comment.where(user_id: @user.id)
    @votes = 0
    Comment.where(user_id: @user.id).each{ |c| @votes += (c.upvotes.size - c.downvotes.size) }
    @votes -= Comment.where(user_id: @user.id).size
  end
end
