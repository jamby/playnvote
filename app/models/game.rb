class Game < ActiveRecord::Base
  serialize :platform, Array
  attr_accessible :platform, :release_date, :title
  
  def to_param
    "#{id} #{title}".parameterize
  end
end
