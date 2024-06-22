# frozen_string_literal: true

class AllergyRecordsController < ApplicationController
  def create
    @allergy_record = AllergyRecord.new(allergy_record_params)
    @pet = Pet.find(@allergy_record.pet_id)
    if @allergy_record.save
      redirect_to new_allergy_reaction_path(@allergy_record.id)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def new
    @pet = Pet.find(params[:format])
    @allergy_record = AllergyRecord.new(pet_id: @pet.id)
  end

  # def show
  #   @allergy_record = AllergyRecord.find(params[:id])
  #   @allergy_reactions = AllergyReaction.find_by(allergy_record_id: params[:id])
  #   @pet = Pet.find(@allergy_record.pet_id)
  # end

  private

  def allergy_record_params
    params.require(:allergy_record).permit(:id, :name, :date_administered, :pet_id)
  end
end
