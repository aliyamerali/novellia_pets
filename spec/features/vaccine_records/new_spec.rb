require 'rails_helper'

RSpec.describe 'New vaccine_record page' do

  before :each do
    @pet = FactoryBot.create(:pet)

    visit 'vaccine_records/new.' + @pet.id.to_s
  end

  it 'has a form to create a new vaccine_record' do
    expect(page).to have_content("New Vaccine Record for #{@pet.name}")
    expect(page).to have_field('Vaccine Name')
    expect(page).to have_select('vaccine_record_date_administered_1i') # Year select box
    expect(page).to have_select('vaccine_record_date_administered_2i') # Month select box
    expect(page).to have_select('vaccine_record_date_administered_3i') # Day select box
    
    expect(page).to have_button('Add Vaccine Record')
  end

  it 'displays errors for missing fields' do
    fill_in 'Vaccine Name', with: ''
    click_button('Add Vaccine Record')

    expect(page).to have_current_path('/vaccine_records')
    expect(page).to have_content("1 error prohibited this vaccine record from being saved:\nName can't be blank")
  end

  it 'redirects to index on submit' do
    fill_in 'Vaccine Name', with: 'Rabies'
    click_button('Add Vaccine Record')

    expect(page).to have_current_path('/')
    within("#pet-id-#{@pet.id}") do
      expect(page).to have_content("Rabies")
      expect(page).to_not have_content("No vaccine records found for this pet.")
    end
  end
end
