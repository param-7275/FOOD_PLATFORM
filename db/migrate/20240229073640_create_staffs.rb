class CreateStaffs < ActiveRecord::Migration[7.1]
  def change
    create_table :staffs do |t|
      t.string :name
      t.integer :contact
      t.string :specialization
      t.references :owner, null: false, foreign_key: true

      t.timestamps
    end
  end
end
