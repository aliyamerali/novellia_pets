# frozen_string_literal: true

class PetsController < ApplicationController
  def create
    @pet = Pet.new(pet_params)
    if @pet.save
      redirect_to pets
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    if params["user_type"] == "owner"
      @pets = Pet.all.order(:name)
    else
      redirect_to root_path
    end
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
    params.require(:pet).permit(:name, :species, :owner_first, :owner_last, :date_of_birth, :user_type)
  end
end
