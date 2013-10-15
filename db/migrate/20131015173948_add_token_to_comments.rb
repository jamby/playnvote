class AddTokenToComments < ActiveRecord::Migration
  def change
    add_column :comments, :token, :string
  end
end
