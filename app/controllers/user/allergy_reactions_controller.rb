# frozen_string_literal: true

module User
  class AllergyReactionsController < ApplicationController
    def create
      @allergy_reaction = AllergyReaction.new(allergy_reaction_params)
      @allergy_record = AllergyRecord.find(@allergy_reaction.allergy_record_id)
      @pet = Pet.find(@allergy_record.pet_id)
      if @allergy_reaction.save
        redirect_to "/user/#{params[:user_id]}/allergy_reactions/new?allergy_record_id=#{@allergy_record.id}"
      else
        render :new, status: :unprocessable_entity
      end
    end

    def new
      @allergy_record = AllergyRecord.find(params[:allergy_record_id])
      @pet = Pet.find(@allergy_record.pet_id)
      @user_id = params[:user_id]
      @allergy_reaction = AllergyReaction.new(allergy_record_id: @allergy_record.id)
    end

    private

    def allergy_reaction_params
      params.require(:allergy_reaction).permit(:user_id, :allergy_record_id, :reaction, :severity)
    end
  end
end
