class AddInstrumentVersionToOptionAssoc < ActiveRecord::Migration
  def change
    add_column :option_associations, :instrument_version, :integer
  end
end
