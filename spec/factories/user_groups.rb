FactoryBot.define do
  factory :user_group do
    name { Faker::Football.team }
    emails { [Faker::Internet.email, Faker::Internet.email] }
  end
end
