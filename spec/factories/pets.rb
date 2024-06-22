# frozen_string_literal: true

species_options = ['bird', 'cat', 'chicken', 'dog', 'ferret', 'fish', 'guinea_pig', 'hampster', 'rabbit', 'reptile']

FactoryBot.define do
  factory :pet do
    name { Faker::Name.name }
    species { species_options.sample }
    owner_first { Faker::Name.name }
    owner_last { Faker::Name.name }
    date_of_birth { Faker::Date.in_date_period }
  end
end
