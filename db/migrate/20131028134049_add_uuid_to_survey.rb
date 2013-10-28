class AddUuidToSurvey < ActiveRecord::Migration
  def change
    add_column :surveys, :uuid, :string, unique: true
    add_index(:surveys, :uuid)
  end
end
