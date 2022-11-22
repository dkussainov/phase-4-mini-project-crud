class SpicesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

    def index
        spices = Spice.all
        render json: spices, except: [:created_at, :updated_at], status: :ok
    end

    def show
        spice = find_spice
        render json: spice, except: [:created_at, :updated_at], status: :ok

    end

    def create
        spice = Spice.create(spices_params)
        render json: spice, except: [:created_at, :updated_at], status: :created
    end

    def update
        spice = find_spice
        spice.update(spices_params)
        render json: spice, except: [:created_at, :updated_at]
    end

    def destroy
        spice = find_spice
        spice.destroy
        head :no_content
    end

    private

    def spices_params
        params.permit(:title, :description, :image, :notes, :rating)
    end

    def render_not_found_response
        render json: { error: "Spice not found" }, status: :not_found
      end
    
      def find_spice
        Spice.find(params[:id])
      end
end
