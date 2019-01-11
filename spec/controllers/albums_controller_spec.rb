require "rails_helper"

RSpec.describe AlbumsController, type: :controller do
  let(:album_params) { { album: attributes_for(:album) } }
  let(:json_response) { JSON.parse(response.body) }

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
  end

  describe "PUT /album" do
    let(:json) { JSON.parse(response.body) }
    let!(:album) { create :album }

    context "when valid parameters provided" do
      before do
        put :update, params: { album: { title: "New Title" }, id: album.id }
      end

      it { is_expected.to respond_with 200 }
      it "updates the album title successfully" do
        expect(json["data"]["attributes"]["title"]).to eq("New Title")
      end
    end

    context "when invalid parameters provided" do
      before do
        put :update, params: { album: { title: "New-title" }, id: album.id }
      end

      it { is_expected.to respond_with 422 }
      it "fails to update album title" do
        expect(json["title"][0]).to eq("Only alphanumerics allowed")
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
