require "rails_helper"

RSpec.describe User, type: :model do
  let!(:user) { create :user }
  it do
    should validate_uniqueness_of(:email).
      with_message("Already exists")
  end
  it { should belong_to(:role) }

  it { should allow_value("brian@andela.com").for(:email) }
  it do
    should_not allow_value("brian").for(:email).
      with_message("should be a valid Andela email address")
  end

  it { should allow_value("brian").for(:first_name) }
  it do
    should_not allow_value("@#$%^1234").for(:first_name).
      with_message("should only have alphabetical characters")
  end

  it { should allow_value("elijah").for(:last_name) }
  it do
    should_not allow_value("123very").for(:last_name).
      with_message("should only have alphabetical characters")
  end
end
