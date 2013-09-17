class GamesController < ApplicationController
  # respond :html, :json
  
  def index
    @games = Game.all
    respond_to do |format|
      format.html
      format.json { render json: { games: @games } }
    end
  end
  
  def new
    @game = Game.new
  end

  def show
    @game = Game.find(params[:id])
    
    # This is the auto-complete
    @game_eval = @game.instance_eval{|g|{title: g.title, id: g.id}}
    @games = Game.all.map{|g|{title: g.title, id: g.id}}
    @games.delete(@game_eval)

    @relatedGames = RelatedGame.where(game1_id: @game.id) + RelatedGame.where(game2_id: @game.id)
    
    # More auto-complete
    respond_to do |format|
      format.html
      format.json { render json: {games: @games}}
    end
  end
  
  def search_related
    @current_game = Game.find(params[:current_game])
    @search_game = Game.find(params[:search_game_id])
    
    @find_related = RelatedGame.where(game1_id: [@current_game.id, @search_game.id], game2_id: [@current_game.id, @search_game.id])

    if !@find_related.empty?
      redirect_to related_game_path(@find_related.first.id)
    else
      @new_related = RelatedGame.create(game1_id: @current_game.id, game2_id: @search_game.id)
      redirect_to related_game_path(@new_related.id)      
    end
  end
end
