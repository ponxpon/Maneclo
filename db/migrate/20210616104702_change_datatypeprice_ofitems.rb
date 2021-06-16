class ChangeDatatypepriceOfitems < ActiveRecord::Migration[5.2]
  def change
    change_column :items, :price, :integer
  end
end
