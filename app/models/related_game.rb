class RelatedGame < ActiveRecord::Base
  attr_accessible :game1_id, :game2_id

  belongs_to :game1, class_name: "Game", foreign_key: "game1_id"
  belongs_to :game2, class_name: "Game", foreign_key: "game2_id"
  
  acts_as_votable
end
