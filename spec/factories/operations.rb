FactoryBot.define do
  factory :operation do
    account { create(:account) }
    kind { "MyString" }
    recipient { "MyString" }
  end
end
