require 'rails_helper'

RSpec.describe Operation, type: :model do
  context "associations" do
    it { is_expected.to belong_to(:account) } 
  end

  context "validations" do
    it { is_expected.to validate_presence_of(:amount) }
    it { is_expected.to validate_presence_of(:kind) }
    it { is_expected.to validate_numericality_of(:amount).is_greater_than(0) }
  end
end
