require "rails_helper"

RSpec.describe "Centers", type: :request do
  describe "GET /centers" do
    let!(:center) { create_list(:center, 3) }

    context 'when user is authenticated' do
      before do
        stub_non_admin
        get centers_path
      end

      it "returns a status code of 200" do
        expect(response).to have_http_status(200)
      end

      it "returns all centers" do
        expect(json_response[:data][0][:attributes][:name]).
          to eq(center[0][:name])
        expect(json_response[:data].length).to eq(3)
      end
    end
  end
end
