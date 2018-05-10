require 'bookmark'

describe Bookmark do
  it 'returns an array of bookmarks' do
    expected_bookmarks = [
       'http://makersacademy.com',
       'http://destroyallsoftware.com',
       'http://google.com'
     ]

     connection = PG.connect(dbname: 'bookmark_manager_test')
     connection.exec("INSERT INTO bookmarks (url) VALUES('http://makersacademy.com');")
     connection.exec("INSERT INTO bookmarks (url) VALUES('http://destroyallsoftware.com');")
     connection.exec("INSERT INTO bookmarks (url) VALUES('http://google.com');")

    expect(described_class.all).to eq expected_bookmarks
  end

  context '#add' do
    it 'adds a url to the array of bookmarks' do
      described_class.add('http://thoughtbot.com', 'thoughtbot')
      expect(described_class.all).to include 'http://thoughtbot.com'
    end

    it 'does not add an incorrect url' do
      described_class.add('not a valid url')
      expect(described_class.all).not_to include 'not a valid url'
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

end
