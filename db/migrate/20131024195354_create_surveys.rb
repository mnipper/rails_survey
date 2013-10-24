class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.integer :instrument_id
      t.string :device_id

      t.timestamps
    end
  end
end
