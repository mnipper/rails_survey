class RenameInstrumentVersion < ActiveRecord::Migration
  def change
    rename_column :questions, :instrument_version, :instrument_version_number
    rename_column :options, :instrument_version, :instrument_version_number
  end
end
