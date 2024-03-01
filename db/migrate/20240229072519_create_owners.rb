class CreateOwners < ActiveRecord::Migration[7.1]
  def change
    create_table :owners do |t|
      t.string :username
      t.string :email
      t.string :password_digest
      t.string :contact
      t.string :r_name
      t.string :r_address

      t.timestamps
    end
  end
end