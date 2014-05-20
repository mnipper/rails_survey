ActiveAdmin.register Option do
  menu priority: 7
  permit_params :question_id, :text, :next_question, :number_in_question

  form do |f|
   f.inputs "Option Details" do
    f.input :question, collection: Question.all.collect {|p| [p.text, p.id]} 
    f.input :text
    f.input :number_in_question
    f.input :next_question
   end
   f.actions
 end
  
end
