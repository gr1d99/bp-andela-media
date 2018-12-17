require "rails_helper"

RSpec.describe Album, type: :model do
  describe Album do
    it do
      should validate_presence_of(:title).
        with_message("Cannot be blank for an album")
    end
    it do
      should validate_presence_of(:user_id).
        with_message("Cannot be blank for an album")
    end

    it { should allow_value("my title").for(:title) }
    it { should_not allow_value("title$%^").for(:title) }
    it { should validate_length_of(:title).is_at_most(64) }
    it { should have_and_belong_to_many(:user_groups) }
  end
end
