require 'rails_helper'

RSpec.describe Account, type: :model do
  context "associations" do
    it { is_expected.to belong_to(:customer) } 
  end

  context "validations" do
    it { is_expected.to validate_presence_of(:account_number) }
    it { is_expected.to validate_presence_of(:balance)}
    it { is_expected.to validate_presence_of(:customer_id)}
    it { is_expected.to validate_numericality_of(:balance).is_greater_than_or_equal_to(0) }

    %w[
      abcdfgh
      123456789ab
      ab145879cxv
      @1a254#$%a!
      invalid
      ].each do |account_number|
        it "requires #{account_number} as valid account_number" do
          account = Account.create(account_number: account_number)
          expect(account.errors[:account_number].size).to be >= 1
        end
      end

      %w[
        123456789
        154679584651
        14896301746872
        ].each do |account_number|
          it "requires #{account_number} as valid account_number length" do
            account = Account.create(account_number: account_number)
            expect(account.errors[:account_number].size).to be >= 1
          end
        end
        
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
