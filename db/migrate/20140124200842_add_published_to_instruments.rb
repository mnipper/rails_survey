class AddPublishedToInstruments < ActiveRecord::Migration
  def change
    add_column :instruments, :published, :boolean
  end
end
