require "rails_helper"

RSpec.describe Album, type: :model do
  specify do
    should validate_presence_of(:title).
        with_message("Cannot be blank for an album")
  end

  specify do
    should validate_presence_of(:user_id).
        with_message("Cannot be blank for an album")
  end

  it { should allow_value("my title").for(:title) }
  it { should_not allow_value("title$%^").for(:title) }
  it { should validate_length_of(:title).is_at_most(64) }
  it { should have_and_belong_to_many(:user_groups) }

  describe "#search" do
    let!(:album) { create(:album, title: "New Album") }
    let!(:album2) { create(:album, title: "Another one") }

    it "searches an album" do
      result = described_class.search("new album")
      expect(result).to eq([album])
    end

    it "returns all albums when search query is not provided" do
      result = described_class.search("")
      expect(result).to match_array([album, album2])
    end

    it "returns no albums when search query does not match" do
      result = described_class.search("nice")
      expect(result).to eq([])
    end
  end

  it { should allow_value("my title").for(:title) }
  it { should_not allow_value("title$%^").for(:title) }
  it { should validate_length_of(:title).is_at_most(64) }
  it { should have_and_belong_to_many(:user_groups) }
  it { should belong_to(:center) }

  describe "#search_tag" do
    let!(:albums) { create_list(:album, 2) }
    let(:first_album) { albums.first }
    let(:second_album) do
      album = albums.last
      album.tag_list.add(%w[beautiful awesome])
      album.save
      album
    end

    it "searches by a tag" do
      first_album.tag_list.add(%w[good awesome])
      first_album.save
      results = described_class.search_tag("awesome")

      expect(results).to match_array([first_album])
    end

    it "searches by multiple tags" do
      results = described_class.search_tag(%w[awesome beautiful])
      expect(results).to match_array([second_album])
    end

    it "returns an empty array when name is empty" do
      results = described_class.search_tag("")
      expect(results).to match_array([])
    end
  end
end