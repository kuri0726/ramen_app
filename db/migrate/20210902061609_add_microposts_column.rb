class AddMicropostsColumn < ActiveRecord::Migration[6.1]
  def change
    add_column :microposts, :store_id, :integer
    add_column :microposts, :ate_food, :string
    add_column :microposts, :visit_date, :date
    add_column :microposts, :visit_time, :time
    add_column :microposts, :score, :integer
    add_column :microposts, :waiting_time, :integer
  end
  add_index :microposts, [:store_id]
end
