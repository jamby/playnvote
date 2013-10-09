class AddCoverArtAndGiantBombIdToGames < ActiveRecord::Migration
  def change
    add_column :games, :cover_art, :string
    add_column :games, :giant_bomb_id, :integer
  end
end
