# frozen_string_literal: true

FactoryBot.define do
    factory :allergy_record do
      pet_id { Faker::IdNumber }
      name { Faker::Name.name }
    end
  end
  