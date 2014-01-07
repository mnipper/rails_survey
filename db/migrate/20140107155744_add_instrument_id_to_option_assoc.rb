class AddInstrumentIdToOptionAssoc < ActiveRecord::Migration
  def change
    add_column :option_associations, :instrument_id, :integer
  end
end
