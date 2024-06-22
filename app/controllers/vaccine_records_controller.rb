# frozen_string_literal: true

class VaccineRecordsController < ApplicationController
  def create
    @vaccine_record = VaccineRecord.new(vaccine_record_params)
    @pet = Pet.find(@vaccine_record.pet_id)
    if @vaccine_record.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def new
    @pet = Pet.find(params[:format])
    @vaccine_record = VaccineRecord.new(pet_id: @pet.id)
  end

  private

  def vaccine_record_params
    params.require(:vaccine_record).permit(:name, :date_administered, :pet_id)
  end
end
