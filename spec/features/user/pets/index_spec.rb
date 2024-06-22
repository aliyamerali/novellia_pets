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
    @pet4 = FactoryBot.create(:pet, created_by: 'different_user')

    visit('user/system/pets')
  end

  it 'shows the names of each pet in the system created by the user' do
    within('#pets-list') do
      expect(page).to have_content(@pet1.name)
      expect(page).to have_content(@pet2.name)
      expect(page).to have_content(@pet3.name)
      expect(page).to_not have_content(@pet4.name)
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

  it 'has a button to add a pet that redirects to a form' do
    expect(page).to have_button('Add a Pet')

    click_button('Add a Pet')
    expect(page).to have_current_path('/user/system/pets/new')
  end

  it 'has a link to add a vaccine record for each pet' do
    within('#pets-list') do
      expect(page).to have_link('Add Vaccine Record', count: 3)
    end
  end

  it 'has a link to add an allergy record for each pet' do
    within('#pets-list') do
      expect(page).to have_link('Add Allergy Record', count: 3)
    end
  end

  it 'has a link to add an allergy reaction to each allergy record' do
    within("#pet-id-#{@pet1.id}") do
      expect(page).to have_link('Add Reaction', count: 2)
    end
  end
end
