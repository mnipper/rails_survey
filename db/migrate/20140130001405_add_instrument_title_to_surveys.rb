class AddInstrumentTitleToSurveys < ActiveRecord::Migration
  def change
    add_column :surveys, :instrument_title, :string
  end
end
