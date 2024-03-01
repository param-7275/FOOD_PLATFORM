class RemoveOwnerFromStaffs < ActiveRecord::Migration[7.1]
  def change
    remove_reference :staffs, :owner, null: false, foreign_key: true
  end
end
