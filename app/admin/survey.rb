ActiveAdmin.register Survey do
  sidebar "Survey Associations", only: :show do
    ul do
      li link_to "Responses",    admin_survey_responses_path(params[:id])
    end
  end
  permit_params :instrument_id, :instrument_version_number, :uuid, :device_id, :instrument_title,
    :device_uuid, :latitude, :longitude, :metadata, :completion_rate
    config.sort_order = "id_desc"
    actions :all, except: [:edit, :new] 
    
    index do
      selectable_column
      column :id do |survey|
        link_to survey.id, admin_survey_path(survey.id)
      end
      column :uuid
      column "Instrument", sortable: :instrument_title do |inst|
        instrument = Instrument.find_by_id(inst.instrument_id)
        instrument ? (link_to inst.instrument_title, admin_instrument_path(inst.instrument_id)) : inst.instrument_title
      end
      column "Instrument Versions", sortable: :instrument_version_number do |version|
        version.instrument_version_number
      end
      column :created_at do |survey|
        time_ago_in_words(survey.created_at) + " ago"
      end
      column :completion_rate
      actions
    end
    
end