FactoryBot.define do
  factory :center do
    name { Faker::Football.team }
  end
end
