# frozen_string_literal: true

module Admin
  class PetsController < ApplicationController
    def index
      @pets = Pet.all.order(:name)
    end
  end
end
