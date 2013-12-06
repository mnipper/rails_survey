class AddChildUpdateCountToInstruments < ActiveRecord::Migration
  def change
    add_column :instruments, :child_update_count, :integer, default: 0
  end
end
