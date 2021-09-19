class CreateFromTos < ActiveRecord::Migration[6.1]
  def change
    create_table :from_tos do |t|
      t.string :between
      t.time :from_to

      t.timestamps
    end
  end
end
