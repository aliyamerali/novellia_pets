# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pet do
  describe 'validations' do
    subject { FactoryBot.create(:pet) } # use FactoryBot to create a pet

    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:species) }
    it { should validate_presence_of(:owner_first) }
    it { should validate_presence_of(:owner_last) }
    it { should validate_presence_of(:date_of_birth) }
    it { should validate_uniqueness_of(:name).scoped_to(:species, :owner_first, :owner_last, :date_of_birth) }
  end

  describe 'relationships' do
    it { should have_many(:vaccine_records) }
    it { should have_many(:allergy_records) }
  end
end
