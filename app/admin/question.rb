ActiveAdmin.register Question do
  menu priority: 6
  permit_params :text, :question_type, :question_identifier, :instrument_id, :following_up_question_identifier, :reg_ex_validation,
          :number_in_instrument, :follow_up_position, :reg_ex_validation_message, :identifies_survey, :instructions
  config.per_page = 10
  config.sort_order = "id_asc"
 
  index do 
    column :id
    column :question_identifier
    column :question_type
    column (:text) { |qst| raw(qst.text) } 
    column :instrument_id
    column :number_in_instrument
    column (:instructions) { |qst| raw(qst.instructions) }
    column :identifies_survey
    column :following_up_question_identifier
    column :follow_up_position
    column :reg_ex_validation
    column :reg_ex_validation_message
    actions
  end

  show do |question|
    attributes_table do
      row :id
      row (:text) { |qst| raw(qst.text) }
      row :question_type
      row :question_identifier
      row (:instructions) {|qst| raw(qst.instructions)}
      row :instrument_id
      row :number_in_instrument
      row :following_up_question_identifier
      row :follow_up_position
      row :reg_ex_validation
      row :reg_ex_validation_message
      row :identifies_survey
      row :child_update_count
      row :created_at
      row :updated_at
      row :deleted_at     
    end
    active_admin_comments
  end
  
 form do |f|
   f.inputs "Question Details" do
    f.input :instrument
    f.input :text
    f.input :question_type, collection: Settings.question_types
    f.input :question_identifier
    f.input :following_up_question_identifier
    f.input :reg_ex_validation
    f.input :reg_ex_validation_message
    f.input :number_in_instrument
    f.input :follow_up_position
    f.input :identifies_survey
    f.input :instructions
   end
   f.actions
 end
  
end
