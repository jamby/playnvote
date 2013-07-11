class CreateRelatedGames < ActiveRecord::Migration
  def change
    create_table :related_games do |t|
      t.integer :game1_id
      t.integer :game2_id
      t.timestamps
    end
  end
end
