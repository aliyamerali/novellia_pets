class AllergyRecord < MedicalRecord
    belongs_to :pet
    has_many :allergy_reactions
end