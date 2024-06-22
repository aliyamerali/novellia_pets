require 'rails_helper'

RSpec.describe 'New pet page' do

  before :each do
    visit 'pets/new'
  end

  it 'has a form to create a new pet' do
    expect(page).to have_content('New Pet')
    expect(page).to have_field('Pet Name')
    expect(page).to have_select('Species')
    expect(page).to have_field('Owner First Name')
    expect(page).to have_field('Owner Last Name')
    expect(page).to have_select('pet_date_of_birth_1i') # Year select box
    expect(page).to have_select('pet_date_of_birth_2i') # Month select box
    expect(page).to have_select('pet_date_of_birth_3i') # Day select box
    
    expect(page).to have_button('Add Pet')
  end

  it 'displays errors for missing fields' do
    fill_in 'Pet Name', with: 'Fido'
    click_button('Add Pet')

    expect(page).to have_current_path('/pets')
    expect(page).to have_content("2 errors prohibited this pet from being saved:\nOwner first can't be blank Owner last can't be blank")
  end

  it 'redirects to index on submit' do
    fill_in 'Pet Name', with: 'Rolf'
    fill_in 'Owner First Name', with: 'Duke'
    fill_in 'Owner Last Name', with: 'Ellington'
    click_button('Add Pet')

    expect(page).to have_current_path('/')
    expect(page).to have_content("Rolf")
    expect(page).to have_content("Duke Ellington")
    expect(page).to have_content("No vaccine records found for this pet.")
    expect(page).to have_content("No allergy records found for this pet.")
  end
end
