class AddDeletedAtToSkips < ActiveRecord::Migration
  def change
    add_column :skips, :deleted_at, :datetime
    add_index :skips, :deleted_at
  end
end
