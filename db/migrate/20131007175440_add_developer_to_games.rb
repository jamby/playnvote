class AddDeveloperToGames < ActiveRecord::Migration
  def change
    add_column :games, :developer, :text
  end
end
