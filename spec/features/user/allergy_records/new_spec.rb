# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'New allergy_record page' do
  before :each do
    @pet = FactoryBot.create(:pet)

    visit "user/system/allergy_records/new?pet_id=#{@pet.id}"
  end

  it 'has a form to create a new allergy_record' do
    expect(page).to have_content("New Allergy Record for #{@pet.name}")
    expect(page).to have_field('Allergy Name')

    expect(page).to have_button('Add Allergy Record')
  end

  it 'displays errors for missing fields' do
    fill_in 'Allergy Name', with: ''
    click_button('Add Allergy Record')

    expect(page).to have_current_path('/user/system/allergy_records')
    expect(page).to have_content("1 error prohibited this allergy record from being saved:\nName can't be blank")
  end

  it 'redirects to reaction create page on submit' do
    fill_in 'Allergy Name', with: 'Pollen'
    click_button('Add Allergy Record')

    expect(page).to have_current_path(%r{allergy_reactions/new}, url: true)
    expect(page).to have_content("Pollen Allergy Record for #{@pet.name}")
    expect(page).to have_select('Reaction')
    expect(page).to have_select('Severity')
    expect(page).to have_button('Add Allergy Reaction')
  end
end
