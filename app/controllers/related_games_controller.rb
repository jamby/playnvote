class RelatedGamesController < ApplicationController
  respond_to :json

  def upvote
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
  
  def downvote
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
