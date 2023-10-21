class AddApprovedToCustomers < ActiveRecord::Migration[7.1]
  def change
    add_column :customers, :approved, :boolean, null: false, default: false
    add_index :customers, :approved
  end
end
