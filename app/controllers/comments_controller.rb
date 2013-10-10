class CommentsController < ApplicationController
  def create
    @relatedGame = RelatedGame.find_by_token(params[:related_game_id])
    @all_comments = @relatedGame.comment_threads
    @ttl_cmts = params[:comment][:ttl_cmts]
    if (params[:comment].has_key?(:parent_id))
      @parent = Comment.find(params[:comment][:parent_id])
    end
    @comment = Comment.build_from(@relatedGame, current_user.id, params[:comment][:body].gsub(/\r?\n/, "<br />"))
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
  
  def upvote_comment
    if params[:user_id].empty?
      flash.now[:error] = "You need to be logged in!"
      
      respond_to do |format|
        format.js
      end
    else
      @user = User.find(params[:user_id])
      @votedComment = Comment.find(params[:comment_id])
      if @user.voted_on? @votedComment and @user.voted_up_on? @votedComment
        @votedComment.unvote voter: @user
      else
        @user.up_votes @votedComment
      end
      
      respond_to do |format|
        format.json { render json: { upvotes: @votedComment.upvotes.size, downvotes: @votedComment.downvotes.size }.to_json }
      end
    end
  end
  
  def downvote_comment
    if params[:user_id].empty?
      flash.now[:error] = "You need to be logged in!"
      
      respond_to do |format|
        format.js
      end
    else
      @user = User.find(params[:user_id])
      @votedComment = Comment.find(params[:comment_id])
      if @user.voted_on? @votedComment and @user.voted_down_on? @votedComment
        @votedComment.unvote voter: @user
      else
        @user.down_votes @votedComment
      end
    
      respond_to do |format|
        format.json { render json: { upvotes: @votedComment.upvotes.size, downvotes: @votedComment.downvotes.size }.to_json }
      end
    end
  end
end
