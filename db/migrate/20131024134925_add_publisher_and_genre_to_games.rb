class AddPublisherAndGenreToGames < ActiveRecord::Migration
  def change
    add_column :games, :publisher, :text
    add_column :games, :genre, :text
  end
end
