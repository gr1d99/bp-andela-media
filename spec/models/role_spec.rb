require "rails_helper"

RSpec.describe Role, type: :model do
  it do
    should validate_presence_of(:role).
      with_message("Cannot be blank for a role")
  end

  it { should have_many(:users).dependent(:destroy) }
end
