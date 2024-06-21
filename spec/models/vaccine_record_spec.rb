# frozen_string_literal: true

require 'rails_helper'

RSpec.describe VaccineRecord do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:pet_id) }
    it { should validate_presence_of(:date_administered) }
  end

  describe 'relationships' do
    it { should belong_to(:pet) }
  end
end
