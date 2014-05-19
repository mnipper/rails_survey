class AddInstrumentIdToSections < ActiveRecord::Migration
  def change
    add_column :sections, :instrument_id, :integer 
  end
end
