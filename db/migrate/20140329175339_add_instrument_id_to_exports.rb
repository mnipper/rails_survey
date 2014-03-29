class AddInstrumentIdToExports < ActiveRecord::Migration
  def change
        add_column :exports, :instrument_id, :integer 
  end
end
