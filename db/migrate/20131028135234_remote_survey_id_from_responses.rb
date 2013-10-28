class RemoteSurveyIdFromResponses < ActiveRecord::Migration
  def change
    remove_column :responses, :survey_id
  end
end
