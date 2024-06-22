# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

pet_1 = Pet.create(name: 'Quinn', species: 'dog', owner_first: 'June', owner_last: 'Osbourne', date_of_birth: '2019-01-01')
allergy_1 = AllergyRecord.create(pet_id: pet_1.id, name: 'Pollen')
allergy_2 = AllergyRecord.create(pet_id: pet_1.id, name: 'Dust')
AllergyReaction.create(allergy_record_id: allergy_1.id, reaction: 1 , severity: 0)
AllergyReaction.create(allergy_record_id: allergy_2.id, reaction: 3 , severity: 2)
VaccineRecord.create(pet_id: pet_1.id, name: 'Rabies', date_administered: '2021-01-01')

pet_2 = Pet.create(name: 'Ollie', species: 'dog', owner_first: 'Luke', owner_last: 'Bankole', date_of_birth: '2016-06-06')
VaccineRecord.create(pet_id: pet_2.id, name: 'Rabies', date_administered: '2021-01-01')

Pet.create(name: 'Shadow', species: 'cat', owner_first: 'Moira', owner_last: 'Strand', date_of_birth: '2022-03-12')