class RenameOwnerIdToRestaurantIdInItems < ActiveRecord::Migration[7.1]
  def change
    rename_column :items, :owner_id, :restaurant_id
  end
end
