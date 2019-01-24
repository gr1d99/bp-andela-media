require "rails_helper"

describe Albums::CreateAlbum do
  subject { Albums::CreateAlbum }
  let!(:center) { create(:center) }
  let(:valid_params) do
    {
      "album": {
        "title": "My album",
        "description": "This is a test album",
        "user_id": "cfe28054-0468-47b4-ac78-bf2b5c6838cf",
        "tag_list": %w(thanksgiving halloween),
        "center_id": center.id,
        "user_groups": [{
          "name": "Test",
          "emails": %w(test@gmail.com user@gmail.com)
        }]
      }
    }
  end
  let(:user_group_ids_params) { [UserGroup.last.id] }

  context "when params are valid " do
    it "creates an album in the database" do
      expect { subject.call(valid_params) }.
        to change { Album.count }.by(1)
    end

    it "creates a user group in the database" do
      expect { subject.call(valid_params) }.
        to change { UserGroup.count }.by(1)
    end
  end

  context "when a user group id is provided" do
    before do
      FactoryBot.create(:user_group)
      valid_params[:album][:user_group_ids] = user_group_ids_params
      valid_params[:album].delete(:user_groups)
    end

    it "doesn't create a new user group " do
      expect { subject.call(valid_params) }.
        to change { UserGroup.count }.by(0)
    end

    it "creates an album in the database" do
      expect { subject.call(valid_params) }.
        to change { Album.count }.by(1)
    end
  end
end
