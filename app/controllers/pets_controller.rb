class PetsController < ApplicationController
    def create
        @pet = Pet.new(pet_params)
        if @pet.save
            redirect_to root_path
        else
            # binding.pry
            render :new, status: :unprocessable_entity
        end
    end
    
    def index
        @pets = Pet.all.order(:name)
    end

    def new
        @pet = Pet.new
    end
    
    def show
        pet = Pet.find(params[:id])
        render json: pet
    end

    private

    def pet_params
        params.require(:pet).permit(:name, :species, :owner_first, :owner_last, :date_of_birth)
    end
end
  