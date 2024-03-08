class RemovepasswordDigestFromOwners < ActiveRecord::Migration[7.1]
  def change
    remove_column :owners, :password_digest, :string
  end
end
