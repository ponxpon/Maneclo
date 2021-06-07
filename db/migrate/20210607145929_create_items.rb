class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.integer :user_id, null: false
      t.integer :brand_id, null: false
      t.integer :category_id, null: false
      t.string :item_image_id
      t.string :price, null: false
      t.text :introduction
      t.string :purchase_date

      t.timestamps
    end
  end
end
