class CommentsController < ApplicationController
  def create
    @relatedGame = RelatedGame.find(params[:related_game_id])
    @comment = Comment.build_from(@relatedGame, current_user.id, params[:comment][:body])
    if @comment.save
      respond_to do |format|
        format.js
      end
    else
      flash.now[:error] = "Comment was not submitted."
      redirect_to root_path
    end
  end
end
