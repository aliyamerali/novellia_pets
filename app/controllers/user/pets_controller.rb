# frozen_string_literal: true

module User
  class PetsController < ApplicationController
    def create
      pet_params_with_created_by = pet_params.to_h.merge({ created_by: params[:user_id] })
      @pet = Pet.new(pet_params_with_created_by)
      if @pet.save
        redirect_to user_pets_path
      else
        render :new, status: :unprocessable_entity
      end
    end

    def index
      @user_id = params[:user_id]
      @pets = Pet.all.where(created_by: @user_id).order(:name)
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
      params.require(:pet).permit(:name, :species, :owner_first, :owner_last, :date_of_birth, :created_by)
    end
  end
end
