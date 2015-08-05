class AddAdminUser < ActiveRecord::Migration
  def up
    Admin.create!(
        first_name: 'admin',
        last_name: 'admin',
        email: 'admin@admin.fr',
        password: 'adminadmin')
  end

  def down
    Admin.where(email: 'admin@admin.fr').destroy_all
  end
end