module Api
  module V1
    module Frontend
      class GridsController < ApiApplicationController
        respond_to :json
        
        def index
          instrument = current_project.instruments.find(params[:instrument_id])
          respond_with instrument.grids
        end
        
        def create
          instrument = current_project.instruments.find(params[:instrument_id])
          grid = instrument.grids.new(params[:grid])
          if grid.save
            render json: grid, status: :created
          else
            render json: { errors: grid.errors.full_messages }, status: :unprocessable_entity
          end
        end
        
        def update
          instrument = current_project.instruments.find(params[:instrument_id])
          grid = instrument.grids.find(params[:id])
          grid.update_attributes(params[:grid])
          respond_with grid
        end
        
        def destroy
          instrument = current_project.instruments.find(params[:instrument_id])
          grid = instrument.grids.find(params[:id])
          respond_with grid.destroy
        end
        
      end
    end
  end
end
