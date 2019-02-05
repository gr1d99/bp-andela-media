FactoryBot.define do
  factory :role do
    name { Faker::Lorem.word }
  end

  trait :admin_role do
    name { "Admin" }
  end
end
