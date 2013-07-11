class GamesController < ApplicationController
  def new
    @game = Game.new
  end

  def show
    @game = Game.find(params[:id])
    # @user = User.find(params[:id])
    @relatedGames = RelatedGame.where(game1_id: @game.id) + RelatedGame.where(game2_id: @game.id)
  end
end
