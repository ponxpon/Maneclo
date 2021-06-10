class RemovebrandFrombrands < ActiveRecord::Migration[5.2]
  def change
    remove_column :brands, :brand_, :string
  end
end
