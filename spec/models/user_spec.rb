require "rails_helper"

RSpec.describe User, type: :model do
  let!(:user) { create :user }
  it do
    should validate_uniqueness_of(:email).
      with_message(I18n.t("errors.user.unique"))
  end
  it { should belong_to(:role) }

  it { should allow_value("brian@andela.com").for(:email) }
  it do
    should_not allow_value("brian").for(:email).
      with_message(I18n.t("errors.user.invalid_email"))
  end

  it { should allow_value("brian").for(:first_name) }
  it do
    should_not allow_value("@#$%^1234").for(:first_name).
      with_message(I18n.t("errors.user.invalid_first_name"))
  end

  it { should allow_value("elijah").for(:last_name) }
  it do
    should_not allow_value("123very").for(:last_name).
      with_message(I18n.t("errors.user.invalid_last_name"))
  end
end
