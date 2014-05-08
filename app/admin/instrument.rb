ActiveAdmin.register Instrument do
  menu priority: 5
  permit_params :title, :language, :alignment, :previous_question_count, :child_update_count, :published, :show_instructions

  form do |f|
    f.inputs "Instrument Details" do
      f.input :project
      f.input :title
      f.input :language
      f.input :published
    end
    f.actions
  end
  
end
