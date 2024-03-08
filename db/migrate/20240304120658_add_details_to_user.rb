class AddDetailsToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :contact, :integer
    add_column :users, :r_name, :string
    add_column :users, :r_address, :string
  end
end
