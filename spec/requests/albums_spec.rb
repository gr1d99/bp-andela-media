require "rails_helper"

RSpec.describe "Albums", type: :request do
  describe "GET /albums" do
    let!(:center) { create :center }
    let!(:albums) { create_list(:album, 2, center: center) }

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

    context "when the query includes title_cont" do
      it "returns results matching the title content" do
        data = Album.first.title
        get albums_path(title_cont: data)
        expect(json_response[:data][0][:attributes][:title]).to match(data)
      end
    end

    context "when the query includes center" do
      it "returns results matching the center queried" do
        get albums_path(center: center.name)
        res = json_response[:data][0][:attributes][:"center-id"]
        expect(res).to match(center.id)
      end
    end

    context "when the query includes date" do
      it "returns results matching the date album was created" do
        data = Album.first.created_at.to_date
        get albums_path(date: data)
        res = Date.strptime(json_response[:data][0][:attributes][:"created-at"])
        expect(res).to eq(data)
      end
    end
  end
end
