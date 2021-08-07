FactoryBot.define do
  factory :artist do
    name { Faker::Artist.name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    about { Faker::Quote.yoda }
    statement { Faker::Quotes::Shakespeare.hamlet_quote }
    instagram { Faker::Internet.username }
  end
end