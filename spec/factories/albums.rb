FactoryBot.define do
  factory :album do
    title { "Album title" }
    description { Faker::Lorem.paragraph }
    metadata { "" }
    position { 1 }
    preferences { "" }
    user_id { "cfe28054-0468-47b4-ac78-bf2b5c6838cf" }
  end
end
