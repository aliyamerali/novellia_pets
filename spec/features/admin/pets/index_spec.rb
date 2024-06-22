# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Pets Index' do
  before :each do
    @pet1 = FactoryBot.create(:pet)
    @pet1_vaccine1 = FactoryBot.create(:vaccine_record, pet_id: @pet1.id)
    @pet1_vaccine2 = FactoryBot.create(:vaccine_record, pet_id: @pet1.id)
    @pet1_allergy1 = FactoryBot.create(:allergy_record, pet_id: @pet1.id)
    @pet1_allergy1_reaction1 = FactoryBot.create(:allergy_reaction, allergy_record_id: @pet1_allergy1.id)
    @pet1_allergy1_reaction2 = FactoryBot.create(:allergy_reaction, allergy_record_id: @pet1_allergy1.id)
    @pet1_allergy2 = FactoryBot.create(:allergy_record, pet_id: @pet1.id)

    @pet2 = FactoryBot.create(:pet)
    @pet3 = FactoryBot.create(:pet)

    visit('/admin/pets')
  end

  it 'shows the names of each pet in the system' do
    within('#pets-list') do
      expect(page).to have_content(@pet1.name)
      expect(page).to have_content(@pet2.name)
      expect(page).to have_content(@pet3.name)
    end
  end

  it 'shows the vaccine and allergy records and reactions of each pet in the system' do
    within("#pet-id-#{@pet1.id}") do
      expect(page).to have_content(@pet1_vaccine1.name)
      expect(page).to have_content(@pet1_vaccine1.date_administered)
      expect(page).to have_content(@pet1_vaccine2.name)
      expect(page).to have_content(@pet1_vaccine2.date_administered)
      expect(page).to have_content(@pet1_allergy1.name)
      expect(page).to have_content(@pet1_allergy1_reaction1.reaction)
      expect(page).to have_content(@pet1_allergy1_reaction1.severity)
      expect(page).to have_content(@pet1_allergy1_reaction2.reaction)
      expect(page).to have_content(@pet1_allergy1_reaction2.severity)
    end
  end

  it 'indicates when no vaccine and allergy records exist' do
    within("#pet-id-#{@pet2.id}") do
      expect(page).to have_content('No vaccine records found for this pet.')
      expect(page).to have_content('No allergy records found for this pet.')
    end
    within("#pet-id-#{@pet3.id}") do
      expect(page).to have_content('No vaccine records found for this pet.')
      expect(page).to have_content('No allergy records found for this pet.')
    end
  end

  it 'does not have a button to add a pet' do
    expect(page).to_not have_button('Add a Pet')
  end

  it 'does not have a button to add a vaccine record for each pet' do
    within('#pets-list') do
      expect(page).to_not have_button('Add Vaccine Record')
    end
  end

  it 'does not have a button to add an allergy record for each pet' do
    within('#pets-list') do
      expect(page).to_not have_button('Add Allergy Record')
    end
  end

  it 'does not have a button to add an allergy reaction to each allergy record' do
    within("#pet-id-#{@pet1.id}") do
      expect(page).to_not have_button('Add Reaction')
    end
  end
end
