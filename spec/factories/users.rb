FactoryBot.define do
  factory :user do
    sequence(:camper_id) { |n| "-KesEogCwjq#{n}lk#{n}zKmLI" }
    email { "#{Faker::Name.first_name}.#{Faker::Lorem.word}@andela.com" }
    role
  end
end
