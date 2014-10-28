module Api
  module V1
    module Frontend
      class SectionTranslationsController < ApiApplicationController
        respond_to :json
        
        def update
           section = current_project.sections.find(params[:section_id])
           translation = section.translations.find(params[:id])
           respond_with translation.update_attributes(params[:section_translation])
        end
      end
    end
  end
end
