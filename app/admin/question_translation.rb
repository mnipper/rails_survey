ActiveAdmin.register QuestionTranslation do
  menu priority: 9
  permit_params :language, :text, :reg_ex_validation_message, :question_id
  
  form do |f|
   f.inputs "Question Translation Details" do
    f.input :question, collection: Question.all.collect {|p| [p.text, p.id]} 
    f.input :language
    f.input :text
    f.input :reg_ex_validation_message
   end
   f.actions
 end
 
end
