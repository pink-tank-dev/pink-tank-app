FactoryBot.define do
  factory :artist do
    name { Faker::Name.name }
    about { Faker::Quote.yoda }
  end
end