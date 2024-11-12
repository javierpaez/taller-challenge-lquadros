FactoryBot.define do
  factory :book do
    title { Faker::Name.name }
    author { Faker::Name.name }
    year { rand(1900..2023) }
  end
end