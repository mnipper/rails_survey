ActiveAdmin.register Survey do
  permit_params :instrument_id, :instrument_version_number, :uuid, :device_id, :instrument_title,
    :device_uuid, :latitude, :longitude, :metadata, :completion_rate
    config.sort_order = "id_desc"
    actions :all, except: [:edit, :new] 
    
    index do
      selectable_column
      column "Id" do |survey|
        link_to survey.id, admin_survey_path(survey.id)
      end
      column :uuid
      column "Instrument" do |inst|
        link_to inst.instrument_title, admin_survey_path(inst.instrument_id)
      end
      column "Instrument Versions" do |version|
        version.instrument_version_number
      end
      column :created_at do |survey|
        time_ago_in_words(survey.created_at) + " ago"
      end
      column :completion_rate
      actions
    end
    
end