require 'rails_helper'

RSpec.describe Album, type: :album_filter do
  describe ".by_title" do
    context "when title filters exists" do
      let(:title1) { "Fair Day" }
      let(:title2) { "Halloween" }
      let(:album_attributes) { attributes_for(:album) }

      before do
        album_attributes[:title] = title1
        create(:album, album_attributes)
      end

      it "filters albums by title and returns albums" do
        query = generate_filter_query("Fair Day")
        results = described_class.by_title(query)

        expect(results).to match_array([Album.first])
        expect(results.size).to be(1)
      end

      it "filters albums by multiple titles" do
        album_attributes[:title] = title2
        create(:album, album_attributes)

        query = generate_filter_query("#{title1},#{title2}")
        results = described_class.by_title(query)

        expect(results).to match_array(Album.all)
        expect(results.size).to eq(2)
      end
    end

    context "when title filters do not exist" do
      before { create(:album, title: "very invalid") }
      it 'should not return any albums' do
        query = generate_filter_query("1,2,3")
        expect(described_class.by_title(query)).to match_array([])
      end
    end
  end
end