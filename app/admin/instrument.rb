ActiveAdmin.register Instrument do
  menu priority: 5
  permit_params :title, :language, :alignment, :previous_question_count, :child_update_count, :published, :show_instructions, :project_id

  form do |f|
    f.inputs "Instrument Details" do
      f.input :project, collection: Project.all {|i| [i.name, i.id]}
      f.input :title
      f.input :language, collection: Settings.languages
      f.input :published
      f.input :show_instructions
    end
    f.actions
  end
  
end
