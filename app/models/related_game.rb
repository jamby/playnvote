class RelatedGame < ActiveRecord::Base
  before_create :generate_token
  attr_accessible :game1_id, :game2_id, :token

  belongs_to :game1, class_name: "Game", foreign_key: "game1_id"
  belongs_to :game2, class_name: "Game", foreign_key: "game2_id"
  
  acts_as_votable
  acts_as_commentable
  
  def to_param
    self.token
  end
  
protected
  
  def generate_token
    self.token = loop do
      token = SecureRandom.hex(4)
      break token unless RelatedGame.exists?(token: token)
    end
  end
end
