class CreateOwnerDetails < ActiveRecord::Migration[7.1]
  def change
    create_table :owner_details do |t|
      t.string :username
      t.integer :contact
      t.string :email
      t.string :r_name
      t.string :r_address

      t.timestamps
    end
  end
end
