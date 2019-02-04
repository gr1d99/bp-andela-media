require "rails_helper"

RSpec.describe Role, type: :model do
  let!(:role) { create :role }

  specify do
    should validate_presence_of(:name).
      with_message(I18n.t("errors.role.blank"))
  end

  specify do
    should validate_uniqueness_of(:name).
      with_message(I18n.t("errors.role.unique"))
  end

  it { should have_many(:users).dependent(:destroy) }
end
