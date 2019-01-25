require "rails_helper"

RSpec.describe AlbumsController, type: :controller do
  let(:album_params) { { album: attributes_for(:album) } }
  let(:json_response) { JSON.parse(response.body) }

  describe "POST /albums" do
    context "when the request is valid" do
      before do
        post :create, params: album_params
      end
    end
  end
end
