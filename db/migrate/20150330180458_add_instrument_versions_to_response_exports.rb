class AddInstrumentVersionsToResponseExports < ActiveRecord::Migration
  def change
    add_column :response_exports, :instrument_versions, :text
  end
end
