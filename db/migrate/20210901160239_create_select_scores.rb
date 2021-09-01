class CreateSelectScores < ActiveRecord::Migration[6.1]
  def change
    create_table :select_scores do |t|
      t.integer :select_score

      t.timestamps
    end
  end
end
