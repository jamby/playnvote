class RelatedGamesController < ApplicationController
  respond_to :json

  def index

  end
  
  def show
    @relatedGame = RelatedGame.find(params[:id])
    @game1 = Game.find(RelatedGame.find(params[:id]).game1_id)
    @game2 = Game.find(RelatedGame.find(params[:id]).game2_id)
    @comments = @relatedGame.comment_threads
    @new_comment = Comment.build_from(@relatedGame, current_user.id, "")
  end

  def upvote
    if params[:user_id].empty?
      flash.now[:error] = "You need to be logged in!"
      
      respond_to do |format|
        format.js
      end
    else
      @user = User.find(params[:user_id])
      @game1 = Game.find(params[:game1_id])
      @game2 = Game.find(params[:game2_id])
      relatedGames = RelatedGame.where(game1_id: [@game1.id, @game2.id], game2_id: [@game1.id, @game2.id])
      @relatedGame = relatedGames.first
      # logic will go here for the shit.
      if @user.voted_on? @relatedGame and @user.voted_up_on? @relatedGame
        @relatedGame.unvote voter: @user
      else
        @user.up_votes @relatedGame
      end
      
      respond_to do |format|
        format.json { render json: { upvotes: @relatedGame.upvotes.size, downvotes: @relatedGame.downvotes.size }.to_json }
      end
    end
  end
  
  def downvote
    if params[:user_id].empty?
      flash.now[:error] = "You need to be logged in!"
      
      respond_to do |format|
        format.js
      end
    else
      @user = User.find(params[:user_id])
      @game1 = Game.find(params[:game1_id])
      @game2 = Game.find(params[:game2_id])
      relatedGames = RelatedGame.where(game1_id: [@game1.id, @game2.id], game2_id: [@game1.id, @game2.id])
      @relatedGame = relatedGames.first
      # logic will go here for the shit.
      if @user.voted_on? @relatedGame and @user.voted_down_on? @relatedGame
        @relatedGame.unvote voter: @user
      else
        @user.down_votes @relatedGame
      end
    
      respond_to do |format|
        format.json { render json: { upvotes: @relatedGame.upvotes.size, downvotes: @relatedGame.downvotes.size }.to_json }
      end
    end
  end

end
