class AddLanguageAndAlignmentToInstruments < ActiveRecord::Migration
  def change
    add_column :instruments, :language, :string
    add_column :instruments, :alignment, :string
  end
end
