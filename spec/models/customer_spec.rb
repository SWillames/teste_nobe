require 'rails_helper'

RSpec.describe Customer, type: :model do
  context 'validations' do
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_presence_of(:cpf) }
    it { is_expected.to validate_presence_of(:address) }
    it { is_expected.to validate_presence_of(:rg) }

    before(:each) do
      customer = create(:customer)
      @customer1 = build(:customer, email: customer.email, cpf: customer.cpf)
    end

    it 'expected validate uniqueness of email' do
      expect validate_uniqueness_of(:email).ignoring_case_sensitivity
      expect(@customer1).not_to be_valid
      expect(@customer1.errors[:email]).to be_present
    end

    it 'expected validate uniqueness of cpf' do
      expect validate_uniqueness_of(:cpf)
      expect(@customer1).not_to be_valid
    end

    %W[
    invalid
    a@a
    a@a.a
    a..@example.org
    a..a@example.org
    ].each do |email|
      it "requires #{email} a valid email" do
        customer = Customer.create(email: email)
        expect(customer.errors[:email].size).to be>=1
      end
    end

    %W[
    j-doe@example.com
    john@example.com
    john.doe@example.com
    jhon_doe@example.com
    jhon@sub.example.com
    john@example-domain.com
    jhon@example.io
    john@example.com.br
    john@example.co.uk
    john+spam@example.com
    JOHN@EXAMPLE.COM
    sergio@google.com
    ].each do |email|
        it "Accepts valid email #{email}" do
          customer = Customer.create(email: email) 
          expect(customer.errors[:email].count).to eq 0
        end
    end
  
    %w[
		abcdfgh
		123456789ab
		ab145879cxv
		@1a254#$%a!
		12345
		invalid
		].each do |cpf|
			it "requires #{cpf} as valid cpf" do
				customer = Customer.create(cpf: cpf)
				expect(customer.errors[:cpf].size).to be >= 1
			end
    end
    
    %w[
		123456789
		1234567891011
		154679584651
		14896301746872
		12345
		].each do |cpf|
			it "requires #{cpf} as valid cpf length" do
				customer = Customer.create(cpf: cpf)
				expect(customer.errors[:cpf].size).to be >= 1
			end
    end
    
    %w[
		12345678910
		12345678911
		15467958465
		14896301746
		12345965471
		].each do |cpf|
			it "requires #{cpf} as valid cpf length" do
				customer = Customer.create(cpf: cpf)
				expect(customer.errors[:cpf].size).to eq 0
			end
		end
  end

end
