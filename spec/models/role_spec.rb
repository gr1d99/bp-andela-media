require "rails_helper"

RSpec.describe Role, type: :model do
  let!(:role) { create :role }
  it do
    should validate_presence_of(:name).
      with_message("Cannot be blank for a role")
  end
  it do
    should validate_uniqueness_of(:name).
      with_message("Already exists")
  end

  it { should have_many(:users).dependent(:destroy) }
end
