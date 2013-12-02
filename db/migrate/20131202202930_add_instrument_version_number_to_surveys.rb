class AddInstrumentVersionNumberToSurveys < ActiveRecord::Migration
  def change
    add_column :surveys, :instrument_version_number, :integer
  end
end
