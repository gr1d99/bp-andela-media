require "rails_helper"
require "faker"

RSpec.describe UserGroupsController, type: :controller do
  describe "POST /user_groups" do
    let(:valid_attributes) do
      {
        name: "cohort 1",
        emails: [Faker::Internet.email],
      }
    end
    let(:invalid_attributes) { { emails: [Faker::Internet.email] } }

    context "when request attributes are valid" do
      before { post :create, params: { user_group: valid_attributes } }

      it "returns status code 201" do
        expect(response).to have_http_status(201)
      end

      it "creates a new user group" do
        expect(response.body).to include "id"
        expect(response.body).to include "emails"
        expect(json_response[:data][:attributes][:name]).to eq("cohort 1")
      end
    end

    context "when user group name is not given" do
      before { post :create, params: { user_group: invalid_attributes } }

      it "returns status code 400" do
        expect(response).to have_http_status(400)
      end

      it "returns reason for the failed request" do
        expect(json_response[:name][0]).to eq("can't be blank")
      end
    end

    context "when user group key is not passed as params" do
      before { post :create, params: valid_attributes }

      it "returns status code 400" do
        expect(response).to have_http_status(400)
      end

      it "returns reason for the failed request" do
        expect(json_response[:message]).
          to eq("param is missing or the value is empty: user_group")
      end
    end
  end
end
