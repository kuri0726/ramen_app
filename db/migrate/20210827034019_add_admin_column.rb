class AddAdminColumn < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :admin, :boolean, defalut: false
  end
end
