class AddStoreInformation < ActiveRecord::Migration[6.1]
  def change
    add_column :stores, :address, :string
    add_column :stores, :telephone_number, :string
    add_column :stores, :business_hours, :string
    add_column :stores, :holiday, :string
  end
end
