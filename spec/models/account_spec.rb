require 'rails_helper'

RSpec.describe Account, type: :model do
  context "associations" do
    it { is_expected.to belong_to(:customer) } 
  end

  context "validations" do
    it { is_expected.to validate_presence_of(:customer_id)}
    
        
        %w[
        123456
        12345789
        1546
        14891
        1234596
        ].each do |account_number|
          it "requires #{account_number} as valid account_number length" do
            account = Account.create(account_number: account_number)
            expect(account.errors[:account_number].size).to eq 0
          end
        end
  end
end
