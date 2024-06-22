# frozen_string_literal: true

class AllergyReaction < ApplicationRecord
  validates :allergy_record_id, :reaction, :severity, presence: true
  enum severity: {
    mild: 0,
    moderate: 1,
    severe: 2
  }

  enum reaction: {
    facial_swelling: 0,
    hives: 1,
    itchy_skin: 2,
    respiratory_distress: 3,
    vommiting: 4
  }

  belongs_to :allergy_record
end
