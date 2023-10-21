class AddPersonalInformationToCustomers < ActiveRecord::Migration[7.1]
  def change
    add_column :customers, :first_name, :string, null: false
    add_column :customers, :last_name, :string, null: false
    add_column :customers, :born_on, :date
    add_column :customers, :street, :string
    add_column :customers, :zip_code, :string
    add_column :customers, :city, :string
  end
end
