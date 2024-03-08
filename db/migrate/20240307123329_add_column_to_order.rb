class AddColumnToOrder < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :contact, :integer
  end
end
