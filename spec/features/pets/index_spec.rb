# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Pets Index' do
  before :each do
    @pet_1 = FactoryBot.create(:pet)
    @pet_1_vaccine_1 = FactoryBot.create(:vaccine_record, pet_id: @pet_1.id)
    @pet_1_vaccine_2 = FactoryBot.create(:vaccine_record, pet_id: @pet_1.id)
    @pet_1_allergy_1 = FactoryBot.create(:allergy_record, pet_id: @pet_1.id)
    @pet_1_allergy_1_reaction_1 = FactoryBot.create(:allergy_reaction, allergy_record_id: @pet_1_allergy_1.id)
    @pet_1_allergy_1_reaction_2 = FactoryBot.create(:allergy_reaction, allergy_record_id: @pet_1_allergy_1.id)
    @pet_1_allergy_2 = FactoryBot.create(:allergy_record, pet_id: @pet_1.id)

    @pet_2 = FactoryBot.create(:pet)
    @pet_3 = FactoryBot.create(:pet)

    visit('/')
  end

  it 'shows the names of each pet in the system' do
    within('#pets-list') do
      expect(page).to have_content(@pet_1.name)
      expect(page).to have_content(@pet_2.name)
      expect(page).to have_content(@pet_3.name)
    end
  end

  it 'shows the vaccine and allergy records and reactions of each pet in the system' do
    within("#pet-id-#{@pet_1.id}") do
      expect(page).to have_content(@pet_1_vaccine_1.name)
      expect(page).to have_content(@pet_1_vaccine_1.date_administered)
      expect(page).to have_content(@pet_1_vaccine_2.name)
      expect(page).to have_content(@pet_1_vaccine_2.date_administered)
      expect(page).to have_content(@pet_1_allergy_1.name)
      expect(page).to have_content(@pet_1_allergy_1_reaction_1.reaction)
      expect(page).to have_content(@pet_1_allergy_1_reaction_1.severity)
      expect(page).to have_content(@pet_1_allergy_1_reaction_2.reaction)
      expect(page).to have_content(@pet_1_allergy_1_reaction_2.severity)
    end
  end

  it 'indicates when no vaccine and allergy records exist' do
    within("#pet-id-#{@pet_2.id}") do
      expect(page).to have_content('No vaccine records found for this pet.')
      expect(page).to have_content('No allergy records found for this pet.')
    end
    within("#pet-id-#{@pet_3.id}") do
      expect(page).to have_content('No vaccine records found for this pet.')
      expect(page).to have_content('No allergy records found for this pet.')
    end
  end

  it 'has a button to add a pet that redirects to a form' do
    expect(page).to have_button('Add a Pet')

    click_button('Add a Pet')
    expect(page).to have_current_path('/pets/new')
  end

  it 'has a button to add a vaccine record for each pet' do
    within('#pets-list') do
      expect(page).to have_button('Add Vaccine Record', count: 3)
    end
  end

  it 'has a button to add an allergy record for each pet' do
    within('#pets-list') do
      expect(page).to have_button('Add Allergy Record', count: 3)
    end
  end

  it 'has a button to add an allergy reaction to each allergy record' do
    within("#pet-id-#{@pet_1.id}") do
      expect(page).to have_button('Add Reaction', count: 2)
    end
  end
end
