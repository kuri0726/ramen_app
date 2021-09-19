class AddWeekNumber < ActiveRecord::Migration[6.1]
  def change
    add_column :weeks, :week_number, :integer
  end
end
