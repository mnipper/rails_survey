class AddLockableToAdmins < ActiveRecord::Migration
  def change
    add_column :admin_users, :failed_attempts, :integer, default: 0
    add_column :admin_users, :unlock_token, :string
    add_column :admin_users, :locked_at, :datetime
  end
end
