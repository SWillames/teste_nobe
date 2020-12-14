FactoryBot.define do
  factory :account do
    account_number { "12345" }
    balance { 0.0 }
    customer { create(:customer) }
  end
end
