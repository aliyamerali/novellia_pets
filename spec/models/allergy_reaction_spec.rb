# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AllergyReaction do
  describe 'validations' do
    it { should validate_presence_of(:allergy_record_id) }
    it { should validate_presence_of(:reaction) }
    it { should validate_presence_of(:severity) }
  end

  describe 'relationships' do
    it { should belong_to(:allergy_record) }
  end
end
