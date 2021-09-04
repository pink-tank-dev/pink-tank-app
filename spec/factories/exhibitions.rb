FactoryBot.define do
  factory :exhibition do
    title { Faker::Book.title }
    description { Faker::Internet.email }
    start_at { DateTime.current }
    end_at { 1.month.from_now }
  end
end
