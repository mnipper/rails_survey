class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :name
      t.timestamps
    end
    default_roles = ["admin", "manager", "translator", "analyst", "user"]
    default_roles.each do |role|
      Role.create(:name => role)
    end
    remove_column :users, :roles_mask
  end
end
