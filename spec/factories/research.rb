FactoryBot.define do
  factory :research do
    concluded  false

    trait :completed do
      concluded  true
    end
  end
end
