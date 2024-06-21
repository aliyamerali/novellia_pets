class VaccineRecord < MedicalRecord
    validates :date_administered, presence: true

    belongs_to :pet
end