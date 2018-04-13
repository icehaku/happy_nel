FactoryBot.define do
  factory :research_token do
    token Faker::Lorem.word
    grade Faker::Number.between(0, 10)
    research

    trait :without_grade do
      grade nil
    end
  end
end
