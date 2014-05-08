ActiveAdmin.register Question do
  menu priority: 6
  permit_params :text, :question_type, :question_identifier, :instrument_id, :following_up_question_identifier, :reg_ex_validation,
          :number_in_instrument, :follow_up_position, :reg_ex_validation_message, :identifies_survey, :instructions
          
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
