FactoryBot.define do
  factory :artwork do
    association :artist
    file { Rack::Test::UploadedFile.new('spec/fixtures/dummy.jpg', 'image/jpeg') }
    title { Faker::Book.title }
    description { Faker::Quote.yoda }
    medium { Faker::Color.color_name }
    measurements { Faker::Measurement.height }
    status { Artwork.statuses[:available] }
    position { 1 }
    nft_site_url { Faker::Internet.url }
  end
end
