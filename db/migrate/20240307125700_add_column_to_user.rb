class AddColumnToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :contact, :integer
  end
end
