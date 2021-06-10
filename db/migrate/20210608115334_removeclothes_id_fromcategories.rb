class RemoveclothesIdFromcategories < ActiveRecord::Migration[5.2]
  def change
    remove_column :categories, :clothes_id, :integer
  end
end
