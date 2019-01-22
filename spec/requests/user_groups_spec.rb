require "rails_helper"

RSpec.describe "UserGroups", type: :request do
  describe "PUT /user_groups/<:id>" do
    let!(:user_group) { create :user_group }
    let(:emails) { Faker::Internet.email }
    let(:valid_attributes) do
      {
        name: "cohort 2",
        emails: [emails]
      }
    end

    let(:invalid_attributes) do
      {
        emails: [emails]
      }
    end

    context "when valid user group ID with valid parameters is provided" do
      before do
        put "/user_groups/#{user_group.id}", params: {
          user_group: valid_attributes
        }
      end

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end

      it "updates the user group" do
        expect(json_response[:data][:attributes][:name]).to eq("cohort 2")
        expect(json_response[:data][:attributes][:emails].length).to eq(1)
      end
    end

    context "when user group ID is doesn't exist" do
      before do
        put "/user_groups/d076c4ab-f644-431b-b75a-4a4c6e00a38", params: {
          user_group: valid_attributes
        }
      end

      it "returns status code 404" do
        expect(response).to have_http_status(404)
      end
    end
  end
end
