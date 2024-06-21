# frozen_string_literal: true

class Pet < ApplicationRecord
  validates :name, :species, :owner_first, :owner_last, :date_of_birth, presence: true
  validates :name, uniqueness: { scope: %i[species owner_first owner_last date_of_birth] }
  enum species: {
    bird: 0,
    cat: 1,
    chicken: 2,
    dog: 3,
    ferret: 4,
    fish: 5,
    guinea_pig: 6,
    hampster: 7,
    rabbit: 8,
    reptile: 9
  }

  has_many :vaccine_records, dependent: :destroy
  has_many :allergy_records, dependent: :destroy
end
