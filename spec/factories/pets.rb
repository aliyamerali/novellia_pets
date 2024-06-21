# frozen_string_literal: true

FactoryBot.define do
  factory :pet do
    name { 'Fido' }
    species { 'dog' }
    owner_first { 'John' }
    owner_last { 'Doe' }
    date_of_birth { '2022-01-01' }
  end
end
