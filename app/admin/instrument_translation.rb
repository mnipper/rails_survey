ActiveAdmin.register InstrumentTranslation do
  menu priority: 8
  permit_params :title, :language, :alignment, :instrument_id
  
end
