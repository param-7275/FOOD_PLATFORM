class RemoveFieldToOrder < ActiveRecord::Migration[7.1]
  def change
    remove_column :orders, :restaurant_id, :integer
  end
end
