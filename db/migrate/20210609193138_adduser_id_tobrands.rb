class AdduserIdTobrands < ActiveRecord::Migration[5.2]
  def change
    add_column :brands, :user_id, :integer
  end
end
