# frozen_string_literal: true

class MedicalRecord < ApplicationRecord
  self.abstract_class = true
  validates :name, :pet_id, presence: true
end
