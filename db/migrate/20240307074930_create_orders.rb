class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.integer :quantity
      t.integer :price
      t.integer :item_id
      t.string :status, default: "pending"

      t.timestamps
    end
  end
end
