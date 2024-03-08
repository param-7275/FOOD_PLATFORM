class RemoveColumnFromUser < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :contact, :integer
    remove_column :users, :r_name, :string
    remove_column :users, :r_address, :string
  end
end
