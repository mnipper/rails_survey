ActiveAdmin.register Response do
  permit_params :question_id, :text, :other_response, :special_response, :survey_uuid, :time_started, :time_ended,
    :question_identifier, :uuid, :device_user_id, :question_version
  config.sort_order = "id_desc"
  actions :all, except: :new
  
  index do
    selectable_column
    column "Id" do |response|
      link_to response.id, admin_response_path(response.id)
     end
    column :uuid
    column "Survey" do |s_uuid|
      survey = Survey.find_by_uuid(s_uuid.survey_uuid)
      link_to s_uuid.survey_uuid, admin_survey_path(survey.id)
    end
    column "Question" do |q_id|
      question = Question.with_deleted.find(q_id.question_id)
      link_to q_id.question_id, admin_question_path(question.id)
    end
    column :question_identifier
    column :text
    column :special_response
    column :other_response
    column :created_at do |response|
      time_ago_in_words(response.created_at) + " ago"
    end
    actions
  end
  
  form do |f|
    f.inputs "Response Details" do
    f.input :text
    f.input :other_response
    f.input :special_response, collection: Settings.special_responses
   end
   f.actions
  end
    
end