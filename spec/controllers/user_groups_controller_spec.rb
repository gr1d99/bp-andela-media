require "rails_helper"

RSpec.describe UserGroupsController, type: :controller do
  describe "POST /user_groups" do
    let(:valid_attributes) do
      {
        name: "cohort 1",
        emails: [Faker::Internet.email]
      }
    end
    let(:invalid_attributes) { { emails: [Faker::Internet.email] } }
    let!(:user) { create :user, :admin }

    context "when user is an admin" do
      before { stub_admin }

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

    context "when the user is not an admin" do
      before { stub_non_admin }

      context "when request attributes are valid" do
        before { post :create, params: { user_group: valid_attributes } }

        it "returns status code 403" do
          expect(response).to have_http_status(403)
        end
      end
    end
  end

  describe "GET /user_groups" do
    let!(:admin) { create :user, :admin }

    context "when request is valid" do
      before { stub_admin }
      before { post :create, params: { user_group: { name: "Test" } } }
      before { get :index }

      it "returns all the existing user groups" do
        expect(UserGroup.count).to eq 1
      end

      it { should respond_with(200) }
    end
  end

  describe "GET /user_group/<:id>" do
    let!(:user_group) { create(:user_group) }

    context "when request is valid" do
      before { get :show, params: { id: user_group.id } }

      it { should respond_with(200) }
    end

    context "when the selected item is not found" do
      before { get :show, params: { id: 4 } }

      it { should respond_with(404) }
    end
  end

  describe "DELETE /user_group/<:id>" do
    let!(:admin) { create :user, :admin }
    let!(:user_group) { create :user_group }

    context "when the user is an admin" do
      before { stub_admin }

      context "when a valid user group id is provided" do
        before { delete :destroy, params: { id: user_group.id } }

        it { is_expected.to respond_with 200 }
      end

      context "when invalid user group id is provided" do
        before { delete :destroy, params: { id: "ee-rt-63" } }

        it { is_expected.to respond_with 404 }
      end
    end

    context "when the user is not an admin" do
      before do
        stub_non_admin
        delete :destroy, params: { id: user_group.id }
      end

      it { is_expected.to respond_with 403 }
    end
  end
end
