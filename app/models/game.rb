class Game < ActiveRecord::Base
  serialize :platform, Array
  attr_accessible :platform, :release_date, :title, :cover_art, :giant_bomb_id, :developer
  
  has_many :related_games
  
  def to_param
    "#{id} #{title}".parameterize
  end
end
