FactoryBot.define do
  factory :artist do
    name { Faker::Artist.name }
    about { Faker::Quote.yoda }
    statement { Faker::Quotes::Shakespeare.hamlet_quote }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    instagram { Faker::Internet.username }
  end
end