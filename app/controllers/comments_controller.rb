class CommentsController < ApplicationController
  def create
    @relatedGame = RelatedGame.find(params[:related_game_id])
    @comment = Comment.build_from(@relatedGame, current_user.id, params[:comment][:body])
    if @comment.save
      redirect_to related_game_path(@relatedGame)
    else
      flash.now[:error] = "Comment was not submitted."
      redirect_to root_path
    end
  end
end
