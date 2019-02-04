require "rails_helper"

RSpec.describe User, type: :model do
  let!(:user) { create :user }

  specify do
    should validate_uniqueness_of(:email).
      with_message(I18n.t("errors.user.unique"))
  end

  specify { should belong_to(:role) }

  specify { should allow_value("brian@andela.com").for(:email) }

  specify do
    should_not allow_value("brian").for(:email).
      with_message(I18n.t("errors.user.invalid_email"))
  end

  specify { should allow_value("brian").for(:first_name) }

  specify do
    should_not allow_value("@#$%^1234").for(:first_name).
      with_message(I18n.t("errors.user.invalid_first_name"))
  end

  specify { should allow_value("elijah").for(:last_name) }

  specify do
    should_not allow_value("123very").for(:last_name).
      with_message(I18n.t("errors.user.invalid_last_name"))
  end
end
