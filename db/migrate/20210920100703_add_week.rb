class AddWeek < ActiveRecord::Migration[6.1]

  def change
    add_column :microposts, :week, :integer
  end

end
