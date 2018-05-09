require 'pg'

class Bookmark

  def self.all
    con = PG.connect :dbname => 'bookmark_manager'
    result = con.exec "SELECT url FROM bookmarks"
    result.values.flatten
  end

end
