FactoryBot.define do
  factory :customer do
    email { Faker::Internet.unique.email }
    password { 'secret123' }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    cpf { Faker::IDNumber.brazilian_citizen_number }
    address { Faker::Address.full_address }
    rg { Faker::IDNumber.brazilian_id }
  end
end
