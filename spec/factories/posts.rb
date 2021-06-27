FactoryBot.define do
  factory :post do
    title { Faker::Book.title }
    status { Post.status[:draft] }

    trait :posted do
      status { Post.status[:posted] }
    end
  end
end
