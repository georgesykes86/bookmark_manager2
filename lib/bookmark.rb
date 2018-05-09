require 'pg'

class Bookmark

  # @@bookmarks = ['http://www.google.com', 'http://www.bbc.co.uk/news', 'http://www.corgi']

  def self.all
    # @@bookmarks
    con = PG.connect :dbname => 'bookmark_manager'
  end

end


# con = PG.connect :dbname => 'testdb', :user => 'janbodnar'
#
#     rs = con.exec "SELECT * FROM Cars LIMIT 5"
#
#     rs.each do |row|
#       puts "%s %s %s" % [ row['id'], row['name'], row['price'] ]
#     end
