require "rails_helper"

RSpec.describe Center, type: :model do
  specify do
    should validate_presence_of(:name).
      with_message("can't be blank")
  end

  it { should have_many(:albums) }
end
