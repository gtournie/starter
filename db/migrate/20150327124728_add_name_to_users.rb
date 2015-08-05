class AddNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string, :limit => 40
    add_column :users, :last_name, :string, :limit => 40

    add_index :users, [:last_name, :first_name]
    add_index :users, :email
  end
end

