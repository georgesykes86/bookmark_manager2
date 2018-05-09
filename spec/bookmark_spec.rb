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

end
