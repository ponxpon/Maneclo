class AddbrandNameTobrands < ActiveRecord::Migration[5.2]
  def change
    add_column :brands, :brand_name, :string
  end
end
