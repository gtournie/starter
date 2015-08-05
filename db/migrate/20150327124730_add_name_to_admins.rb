class AddNameToAdmins < ActiveRecord::Migration
  def change
    add_column :admins, :first_name, :string, :limit => 40
    add_column :admins, :last_name, :string, :limit => 40

    add_index :admins, [:last_name, :first_name]
    add_index :admins, :email
  end
end