class AddDeletedAtToInstruments < ActiveRecord::Migration
  def change
    add_column :instruments, :deleted_at, :datetime
  end
end
