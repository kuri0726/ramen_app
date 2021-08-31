class AddKanaColumn < ActiveRecord::Migration[6.1]
  def change
    add_column :stores, :kana, :string
  end
end
