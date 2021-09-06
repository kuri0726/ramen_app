class AddMicropostImage < ActiveRecord::Migration[6.1]
  def change
    add_column :microposts, :micropost_image, :string
  end
end
