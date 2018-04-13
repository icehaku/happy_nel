FactoryBot.define do
  factory :user do
    name  Faker::RuPaul.queen
    email Faker::Internet.email
  end
end
