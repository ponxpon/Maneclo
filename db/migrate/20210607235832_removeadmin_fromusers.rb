class RemoveadminFromusers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :admin, :boolean
  end
end
