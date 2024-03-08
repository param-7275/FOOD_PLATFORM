class AddToCustomer < ActiveRecord::Migration[7.1]
  def change
    add_column :customers, :contact, :integer
  end
end
