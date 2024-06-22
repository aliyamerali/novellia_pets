# frozen_string_literal: true

FactoryBot.define do
  factory :vaccine_record do
    pet_id { Faker::IdNumber }
    name { Faker::Name.name }
    date_administered { Faker::Date.in_date_period }
  end
end
