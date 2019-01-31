require "rails_helper"

RSpec.describe AlbumsController, type: :controller do
  let!(:center) { create(:center) }
  let(:album_params) { { album: attributes_for(:album, center_id: center.id) } }
  let(:invalid_album_params) do
    { album: attributes_for(
      :album, center_id: "random_id"
    ) }
  end
  let(:json_response) { JSON.parse(response.body) }

  describe "GET /albums" do
    let!(:album) { create(:album, title: "New Title") }
    let!(:album) { create(:album, title: "Testers Title") }

    context "when the request is made without providing query params" do
      before do
        get :index
      end

      it { is_expected.to respond_with 200 }
      it "returns all existing albums" do
        expect(json_response["data"].count).to eq(2)
      end
    end

    context "when the request is made with valid query params" do
      before do
        get :index, params: { q: "Testers Title" }
      end

      it { is_expected.to respond_with 200 }
      it "returns albums with a matching title" do
        expect(json_response["data"].count).to eq(1)
      end
    end

    context "when the request is made with invalid query params" do
      before do
        get :index, params: { q: "invalid-title" }
      end

      it { is_expected.to respond_with 200 }
      it "returns data indicating no album exists with a matching title" do
        expect(json_response["data"].count).to eq(0)
      end
    end
  end

  describe "POST /albums" do
    context "when the request is valid" do
      before do
        post :create, params: album_params
      end

      it "returns status code 201" do
        expect(response).to have_http_status(201)
      end
    end

    context "when the title contains non-alphanumeric characters" do
      before do
        post :create, params: { album: { title: "title@@#" } }
      end

      it "returns status code 422 with an error message" do
        expect(response).to have_http_status(422)
        expect(json_response["title"][0]).to eq "Only alphanumerics allowed"
      end
    end

    context "when the title contains >64 characters" do
      before do
        post :create, params: { album: { title: "title" * 20 } }
      end

      it "returns status code 422 with an error message" do
        expect(response).to have_http_status(422)
        expect(json_response["title"][0]).
          to eq "is too long (maximum is 64 characters)"
      end
    end

    context "when the title is not unique" do
      before do
        post :create, params: album_params
        post :create, params: album_params
      end

      it "returns status code 422 with an error message" do
        expect(response).to have_http_status(422)
        expect(json_response["title"][0]).
          to eq "has already been taken"
      end
    end

    context "when the center_id value does not exist" do
      before { post :create, params: invalid_album_params }

      it { is_expected.to respond_with(422) }

      it "returns error message" do
        expect(json_response["center_id"][0]).
          to match(I18n.t("errors.center.exists"))
      end
    end
  end

  describe "PUT /album" do
    let(:json) { JSON.parse(response.body) }
    let!(:album) { create :album }

    context "when valid parameters provided" do
      before do
        put :update,
        params: { album: { title: "New Title", description: "Great Album" },
                  id: album.id }
      end

      it { is_expected.to respond_with 200 }
      it "updates the album title successfully" do
        expect(json["data"]["attributes"]["title"]).to eq("New Title")
      end
      it "updates the album description successfully" do
        expect(json["data"]["attributes"]["description"]).to eq("Great Album")
      end
    end

    context "when invalid parameters provided" do
      before do
        put :update,
        params: { album: { title: "New-title", description: 1 },
                  id: album.id }
      end

      it { is_expected.to respond_with 422 }
      it "fails to update album title" do
        expect(json["title"][0]).to eq("Only alphanumerics allowed")
      end
    end

    context "when the album to be updated does not exist" do
      before do
        put :update,
        params: { album: { title: "New Title", description: 1 },
                  id: 0 }
      end

      it { is_expected.to respond_with 404 }
      it "fails to find the album" do
        expect(json["message"]).to eq("Couldn't find Album")
      end
    end
  end

  describe "DELETE /album" do
    let!(:album) { create :album }

    context "when valid album id is provided" do
      before do
        delete :destroy, params: { id: album.id }
      end

      it { is_expected.to respond_with 200 }
    end

    context "when invalid album id is provided" do
      before do
        delete :destroy, params: { id: "ee-rt-63" }
      end

      it { is_expected.to respond_with 404 }
    end
  end
end
