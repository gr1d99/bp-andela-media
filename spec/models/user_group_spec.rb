require "rails_helper"

RSpec.describe UserGroup, type: :model do
  subject { create(:user_group) }

  it {
    should validate_uniqueness_of(:name).
      with_message("has already been taken")
  }
  it { should_not allow_value("").for(:name) }
  it { should validate_length_of(:name).is_at_most(32) }
  it { should validate_presence_of(:name).with_message("can't be blank") }
  it { should have_and_belong_to_many(:albums) }
end
