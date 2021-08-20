FactoryBot.define do
  factory :post do
    association :artist
    title { Faker::Book.title }
    status { Post.statuses[:draft] }
    body { Faker::Lorem.paragraph }
    published_at { DateTime.current }

    trait :published do
      status { Post.statuses[:published] }
    end
  end
end
