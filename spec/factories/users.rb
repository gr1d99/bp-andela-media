FactoryBot.define do
  factory :user do
    sequence(:id) { |n| "-KesEogCwjq#{n}lk#{n}zKmLI" }
    email { "#{Faker::Name.first_name}.#{Faker::Lorem.word}@andela.com" }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    andela { {} }
    association :role, factory: :role
  end

  trait :admin do
    id { "-KXGy3EB1oimjQgFim8I" }
    email { "admin-user@andela.com" }
    role { create :role, :admin_role }
    first_name { "user" }
    last_name { "admin" }
  end
end
