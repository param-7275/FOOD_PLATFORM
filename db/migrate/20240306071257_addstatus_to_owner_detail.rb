class AddstatusToOwnerDetail < ActiveRecord::Migration[7.1]
  def change
    add_column :owner_details, :status, :boolean, default: false
  end
end
