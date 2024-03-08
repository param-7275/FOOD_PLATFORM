class RemoveColumnsFromOwner < ActiveRecord::Migration[7.1]
  def change
    remove_column :owners, :username, :string
    remove_column :owners, :email, :string
  end
end
