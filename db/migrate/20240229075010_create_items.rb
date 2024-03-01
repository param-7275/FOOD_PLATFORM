class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.string :name
      t.text :description
      t.integer :restaurant_id
      t.string :image
      t.decimal :price

      t.timestamps
    end
  end
end
