# frozen_string_literal: true

class AllergyReactionsController < ApplicationController
    def create
      @allergy_reaction = AllergyReaction.new(allergy_reaction_params)
      @allergy_record = AllergyRecord.find(@allergy_reaction.allergy_record_id)
      @pet = Pet.find(@allergy_record.pet_id)
      if @allergy_reaction.save
        redirect_to new_allergy_reaction_path(@allergy_record.id)
    else
        render :new, status: :unprocessable_entity
      end
    end
  
    def new
        # binding.pry
        @allergy_record = AllergyRecord.find(params[:format])
        @pet = Pet.find(@allergy_record.pet_id)
        @allergy_reaction = AllergyReaction.new(allergy_record_id: @allergy_record.id)
    end
  
    private
  
    def allergy_reaction_params
      params.require(:allergy_reaction).permit(:allergy_record_id, :reaction, :severity)
    end
  end
  