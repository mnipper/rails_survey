class CreateOptionAssociations < ActiveRecord::Migration
  def change
    create_table :option_associations do |t|
      t.integer :option_version
      t.integer :instrument_version
      t.integer :option_id
      t.integer :instrument_id

      t.timestamps
    end
  end
end
