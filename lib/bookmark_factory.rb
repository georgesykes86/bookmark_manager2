class BookmarkFactory

  def initialize
    @bookmarks = ['http://www.google.com', 'http://www.bbc.co.uk/news', 'http://www.corgi']
  end

  def all
    @bookmarks
  end

end
