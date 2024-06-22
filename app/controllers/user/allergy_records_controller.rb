# frozen_string_literal: true

module User
  class AllergyRecordsController < ApplicationController
    def create
      @allergy_record = AllergyRecord.new(allergy_record_params)
      @pet = Pet.find(@allergy_record.pet_id)
      if @allergy_record.save
        redirect_to new_user_allergy_reaction_path(allergy_record_id: @allergy_record.id)
      else
        render :new, status: :unprocessable_entity
      end
    end

    def new
      @pet = Pet.find(params[:pet_id])
      @allergy_record = AllergyRecord.new(pet_id: @pet.id)
    end

    private

    def allergy_record_params
      params.require(:allergy_record).permit(:id, :name, :date_administered, :pet_id)
    end
  end
end
