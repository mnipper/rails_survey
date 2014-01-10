class RemoveOldTables < ActiveRecord::Migration
  def change
    drop_table :question_associations
    drop_table :option_associations
  end
end
