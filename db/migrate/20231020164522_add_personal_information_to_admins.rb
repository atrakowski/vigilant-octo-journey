class AddPersonalInformationToAdmins < ActiveRecord::Migration[7.1]
  def change
    add_column :admins, :first_name, :string, null: false
    add_column :admins, :last_name, :string, null: false
    add_column :admins, :born_on, :date
    add_column :admins, :street, :string
    add_column :admins, :zip_code, :string
    add_column :admins, :city, :string
  end
end
