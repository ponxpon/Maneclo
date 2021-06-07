class CreateBrands < ActiveRecord::Migration[5.2]
  def change
    create_table :brands do |t|
      t.integer :clothes_id, null: false
      t.string :brand_, null: false

      t.timestamps
    end
  end
end
