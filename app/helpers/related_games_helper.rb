module RelatedGamesHelper
  
  def size_classes
    {games: 'icon-large', 
      related_games: 'icon-2x',
      comments: 'icon-2x'}[params[:controller].to_sym]
  end
end
