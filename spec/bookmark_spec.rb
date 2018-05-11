require 'bookmark'

describe Bookmark do

  let(:bookmark1) { Bookmark.new('id' => 1, 'url' => 'hhtp://google.com', 'title' => 'Google') }
  let(:bookmark2) { Bookmark.new('id' => 1, 'url' => 'hhtp://gogle.com', 'title' => 'Gogle') }
  let(:bookmark3) { Bookmark.new('id' => 2, 'url' => 'hhtp://gogle.com', 'title' => 'Gogle') }

  describe '#initialise' do
    it 'shows correct values' do
      expect(bookmark1.id).to eq 1
      expect(bookmark1.title).to eq 'Google'
      expect(bookmark1.url).to eq 'hhtp://google.com'
    end
  end

  describe '#==' do
    it 'returns true for matchin ids' do
        expect(bookmark1).to eq bookmark2
    end

    it 'returns false for different ids' do
      expect(bookmark1).not_to eq bookmark3
    end
  end

end
