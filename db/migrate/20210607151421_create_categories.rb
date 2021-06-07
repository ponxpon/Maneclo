class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.integer :clothes_id, null: false
      t.string :category_name, null: false

      t.timestamps
    end
  end
end
