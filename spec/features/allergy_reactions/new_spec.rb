# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'New allergy_record page' do
  before :each do
    @pet = FactoryBot.create(:pet)
    @allergy_record = FactoryBot.create(:allergy_record, pet_id: @pet.id)

    visit "allergy_reactions/new.#{@allergy_record.id}"
  end

  it 'has a form to create a new allergy_reaction' do
    expect(page).to have_content("New Allergy Reaction for #{@pet.name}'s #{@allergy_record.name} Allergy")
    expect(page).to have_select('Reaction')
    expect(page).to have_select('Severity')

    expect(page).to have_button('Add Allergy Reaction')
  end

  it 'reloads reaction create page on submit' do
    click_button('Add Allergy Reaction')

    expect(page).to have_current_path("/allergy_reactions/new.#{@allergy_record.id}")
    expect(page).to have_content("#{@allergy_record.name} Allergy Record for #{@pet.name}")
    expect(page).to have_select('Reaction')
    expect(page).to have_select('Severity')
    expect(page).to have_button('Add Allergy Reaction')
  end
end
