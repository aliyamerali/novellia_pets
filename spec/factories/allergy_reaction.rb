# frozen_string_literal: true

severity_options = ['mild', 'moderate', 'severe']

reaction_options = ['facial_swelling', 'hives', 'itchy_skin', 'respiratory_distress', 'vommiting']

FactoryBot.define do
    factory :allergy_reaction do
        allergy_record_id { Faker::IdNumber }
        reaction { reaction_options.sample }
        severity { severity_options.sample }
    end
  end
  