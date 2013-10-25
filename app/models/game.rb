class Game < ActiveRecord::Base
  serialize :platform, Array
  serialize :developer, Array
  serialize :publisher, Array
  serialize :genre, Array
  attr_accessible :platform, :release_date, :title, :cover_art, :giant_bomb_id, :developer, :publisher, :genre
  
  has_many :related_games
  
  def to_param
    "#{id} #{title}".parameterize
  end
end
