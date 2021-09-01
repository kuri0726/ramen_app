class CreateSelectTimes < ActiveRecord::Migration[6.1]
  def change
    create_table :select_times do |t|
      t.integer :select_time

      t.timestamps
    end
  end
end
