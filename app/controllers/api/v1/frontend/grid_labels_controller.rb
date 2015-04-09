module Api
  module V1
    module Frontend
      class GridLabelsController < ApiApplicationController
        respond_to :json
        
        def index
          instrument = current_project.instruments.find(params[:instrument_id])
          grid = instrument.grids.find(params[:grid_id])
          respond_with grid.grid_labels
        end
        
        def show
          instrument = current_project.instruments.find(params[:instrument_id])
          grid = instrument.grids.find(params[:grid_id])
          grid_label = grid.grid_labels.find(params[:id])
          respond_with grid_label 
        end
        
        def create
          instrument = current_project.instruments.find(params[:instrument_id])
          grid = instrument.grids.find(params[:grid_id])
          grid_label = grid.grid_labels.new(params[:grid_label])
          if grid_label.save
            render json: grid_label, status: :created
          else
            render json: { errors: grid_label.errors.full_messages }, status: :unprocessable_entity
          end
        end
        
        def update
          instrument = current_project.instruments.find(params[:instrument_id])
          grid = instrument.grids.find(params[:grid_id])
          grid_label = grid.grid_labels.find(params[:id])
          grid_label.update_attributes(params[:grid_label])
          respond_with grid_label
        end
        
        def destroy
          instrument = current_project.instruments.find(params[:instrument_id])
          grid = instrument.grids.find(params[:grid_id])
          grid_label = grid.grid_labels.find(params[:id])
          respond_with grid_label.destroy
        end

      end
    end
  end
end
