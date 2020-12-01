FactoryBot.define do
  factory :operation do
    account { nil }
    kind { "MyString" }
    recipient { "MyString" }
  end
end
