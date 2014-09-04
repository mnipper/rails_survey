class CreateRules < ActiveRecord::Migration
  def change
    create_table :rules do |t|
      t.string :rule_type
      t.integer :instrument_id
      t.string :rule_params

      t.timestamps
    end
  end
end
