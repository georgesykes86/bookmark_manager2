require 'bookmark'

describe Bookmark do

  context '#add' do
    it 'adds a url to the array of bookmarks' do
      described_class.add('http://thoughtbot.com', 'thoughtbot')
      result = described_class.all[0]
      expect(result.url).to eq 'http://thoughtbot.com'
    end

    it 'does not add an incorrect url' do
      described_class.add('not a valid url')
      result = described_class.all.any? { |bookmark| bookmark.url == 'not a valid url' }
      expect(result).to be false
    end

    it 'returns a Bookmark object' do
      result = described_class.add('http://thoughtbot.com', 'thoughtbot')
      expect(result.url).to eq "http://thoughtbot.com"
    end
  end

  describe '#self.create' do
    let(:bookmark) { described_class.create(id: 2, url: 'http://bbc.co.uk', title: 'bbc') }
    it 'creates an instance of Bookmark' do
      expect(bookmark).to be_an_instance_of(described_class)
    end

    it 'gives the bookmark a title, url and an id' do
      expect(bookmark.id).to eq 2
      expect(bookmark.url).to eq "http://bbc.co.uk"
      expect(bookmark.title).to eq "bbc"
    end
  end

  describe '#==' do
    it 'returns true for matchin ids' do
        bookmark1 = Bookmark.new(id: 1, url: 'hhtp://google.com', title: 'Google')
        bookmark2 = Bookmark.new(id: 1, url: 'hhtp://gogle.com', title: 'Gogle')
        expect(bookmark1).to eq bookmark2
    end

    it 'returns false for different ids' do
      bookmark1 = Bookmark.new(id: 1, url: 'hhtp://google.com', title: 'Google')
      bookmark2 = Bookmark.new(id: 2, url: 'hhtp://gogle.com', title: 'Gogle')
      expect(bookmark1).not_to eq bookmark2
    end
  end


end
