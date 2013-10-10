class AddTokenToRelatedGames < ActiveRecord::Migration
  def change
    add_column :related_games, :token, :string
  end
end
