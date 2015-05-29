class AddInstrumentVersion < ActiveRecord::Migration
  def change
    add_column :questions, :instrument_version, :integer, :default => -1
    add_column :options, :instrument_version, :integer, :default => -1
  end
end
