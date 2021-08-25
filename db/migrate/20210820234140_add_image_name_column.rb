class AddImageNameColumn < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :image_name, :string
    add_column :users, :remember_digest, :string
  end
end
