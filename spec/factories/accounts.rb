FactoryBot.define do
  factory :account do
    account_number { "MyString" }
    balance { 1.5 }
    customer { nil }
  end
end
