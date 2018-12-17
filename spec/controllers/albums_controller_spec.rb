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
end
