class AddInstrumentIdToQuestionAssociations < ActiveRecord::Migration
  def change
    add_column :question_associations, :instrument_id, :integer
  end
end
