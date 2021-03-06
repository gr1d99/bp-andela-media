require "rails_helper"

RSpec.describe "Centers", type: :request do
  describe "GET /centers" do
    let!(:center) { create_list(:center, 3) }

    context "when request is valid" do
      before { get centers_path }

      it "returns a status code of 200" do
        expect(response).to have_http_status(200)
      end

      it "returns all centers" do
        expect(json_response[0][:name]).to eq(center[0][:name])
        expect(json_response.length).to eq(3)
      end
    end
  end
end
