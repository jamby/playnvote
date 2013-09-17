class ApplicationController < ActionController::Base
  protect_from_forgery
  after_filter :response_headers
  
  def response_headers
    if request.xhr?
      response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
      response.headers["Pragma"] = "no-cache"
      response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
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
end
