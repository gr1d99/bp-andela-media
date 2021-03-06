require "rails_helper"

RSpec.describe "Albums", type: :request do
  describe "GET /albums" do
    let!(:albums) { create_list(:album, 2) }

    context "when query is empty" do
      it "returns all albums" do
        get albums_path
        expect(response).to have_http_status(200)
      end
    end

    context "when the query is  not empty" do
      it "returns results matching the query" do
        q = Album.first.title
        get albums_path(q: q)
        expect(json_response[:data][0][:attributes][:title]).to match(q)
      end
    end
  end
end
