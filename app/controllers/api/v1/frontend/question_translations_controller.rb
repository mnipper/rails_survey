module Api
  module V1
    module Frontend
      class QuestionTranslationsController < ApiApplicationController
        respond_to :json
        
        def update
           question = current_project.questions.find(params[:question_id])
           translation = question.translations.find(params[:id])
           respond_with translation.update_attributes(params[:question_translation])
        end
      end
    end
  end
end
