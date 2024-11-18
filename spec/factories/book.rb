FactoryBot.define do
  factory :book do
    title { Faker::Name.name }
    author { Faker::Name.name }
    publication_year { rand(1900..2023) }
    rating { rand(0..5) }
    status { 'available' }
  end
end