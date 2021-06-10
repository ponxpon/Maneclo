class RemoveclothesIdFrombrands < ActiveRecord::Migration[5.2]
  def change
    remove_column :brands, :clothes_id, :integer
  end
end
