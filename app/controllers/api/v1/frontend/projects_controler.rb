module Api
  module V1
    module Frontend
      class ProjectsController < ApiApplicationController
        respond_to :json

        def index
          respond_with current_user.projects
        end

        def show
          respond_with current_user.projects.find(params[:id])
        end
      end
    end
  end
end
