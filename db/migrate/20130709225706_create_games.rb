class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :title
      t.date :release_date
      t.text :platform

      t.timestamps
    end
  end
end
