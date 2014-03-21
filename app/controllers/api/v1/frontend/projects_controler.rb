module Api
  module V1
    module Frontend
      class ProjectsController < ApiApplicationController
        respond_to :json

        def index
          respond_with Project.all
        end

        def show
          respond_with Project.find(params[:id])
        end
      end
    end
  end
end
