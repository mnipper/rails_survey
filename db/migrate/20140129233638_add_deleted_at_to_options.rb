class AddDeletedAtToOptions < ActiveRecord::Migration
  def change
    add_column :options, :deleted_at, :datetime
  end
end
