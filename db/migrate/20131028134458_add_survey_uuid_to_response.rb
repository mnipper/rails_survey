class AddSurveyUuidToResponse < ActiveRecord::Migration
  def change
    add_column :responses, :survey_uuid, :string
  end
end
