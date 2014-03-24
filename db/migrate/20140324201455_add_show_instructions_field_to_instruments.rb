class AddShowInstructionsFieldToInstruments < ActiveRecord::Migration
  def change
    add_column :instruments, :show_instructions, :boolean, default: false
  end
end
