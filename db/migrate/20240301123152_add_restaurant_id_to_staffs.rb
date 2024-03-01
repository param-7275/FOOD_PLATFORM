class AddRestaurantIdToStaffs < ActiveRecord::Migration[7.1]
  def change
    add_column :staffs, :restaurant_id, :integer
  end
end
