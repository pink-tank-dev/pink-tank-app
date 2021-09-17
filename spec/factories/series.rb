FactoryBot.define do
  factory :series do
    association :artist
    association :exhibition
    title { Faker::Book.title }
    description { Faker::Lorem.paragraph }
  end
end
