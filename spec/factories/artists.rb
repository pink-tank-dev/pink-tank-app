FactoryBot.define do
  factory :artist do
    name { Faker::Artist.name }
    about { Faker::Quote.yoda }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
  end
end