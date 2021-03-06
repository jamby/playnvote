class GamesController < ApplicationController
  # respond :html, :json
  
  def index
    @games = Hash[Game.pluck(:id).zip(Game.pluck(:title))]
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
    @games = Hash[Game.where("id != ?", @game.id).pluck(:id).zip(Game.where("id != ?", @game.id).pluck(:title))]

    @relatedGames = RelatedGame.where(game1_id: @game.id) + RelatedGame.where(game2_id: @game.id)
    @relatedGames = @relatedGames.sort_by{ |rg| rg.upvotes.size - rg.downvotes.size }.reverse.take(3)
    
    # Get top rated comments per game.
    @rgComments = []
    @relatedGames.each{ |rg| @rgComments << rg.root_comments.sort_by{ |c| c.upvotes.size - c.downvotes.size }.reverse.first }
    
    # More auto-complete
    respond_to do |format|
      format.html
      format.json { render json: { games: @games } }
    end
  end
  
  def search_games
    if !params[:q_id].blank?
      @find_game = Game.find(params[:q_id])
      redirect_to game_path(@find_game)
    else
      flash[:error] = "Game does not exist."
      redirect_to root_path
    end
  end
  
  def search_related
    @current_game = Game.find(params[:current_game])
    @search_game = Game.find(params[:search_game_id])
    
    @find_related = RelatedGame.where(game1_id: [@current_game.id, @search_game.id], game2_id: [@current_game.id, @search_game.id])

    if !@find_related.empty?
      redirect_to related_game_path(@find_related.first)
    else
      @new_related = RelatedGame.create(game1_id: @current_game.id, game2_id: @search_game.id)
      redirect_to related_game_path(@new_related)
    end
  end
end
