module GamesHelper
  def release_date(game)
    if game.release_date
      game.release_date.strftime("%B %-d, %Y")
    else
      "No date recorded"
    end
  end
end
