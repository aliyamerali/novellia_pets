require 'rails_helper'

RSpec.describe AllergyRecord do
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:pet_id) }
  end

  describe 'relationships' do
    it { should belong_to(:pet) }
    it { should have_many(:allergy_reactions) }
  end
end