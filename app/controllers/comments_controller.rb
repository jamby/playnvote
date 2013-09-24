class CommentsController < ApplicationController
  def create
    @relatedGame = RelatedGame.find(params[:related_game_id])
    @all_comments = @relatedGame.comment_threads
    @ttl_cmts = params[:comment][:ttl_cmts]
    if (params[:comment].has_key?(:parent_id))
      @parent = Comment.find(params[:comment][:parent_id])
    end
    @comment = Comment.build_from(@relatedGame, current_user.id, params[:comment][:body])
    if @comment.save
      if @parent
        @comment.move_to_child_of(@parent)
      end
      current_user.up_votes @comment
      respond_to do |format|
        format.js
      end
    else
      flash.now[:error] = "Comment was not submitted."
      redirect_to root_path
    end
  end
  
  def destroy
    @relatedGame = RelatedGame.find(params[:related_game_id])
    @all_comments = @relatedGame.comment_threads
    @comment = Comment.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.js
    end
  end
end
