require 'pg'
require 'uri'
require_relative './database_connection'

class Bookmark

  def self.all
    result = DatabaseConnection.query("SELECT url FROM bookmarks")
    result.values.flatten
  end

  def self.add(url)
    return false unless valid_url?(url)
    DatabaseConnection.query("INSERT INTO bookmarks (url) VALUES ('#{url}');")
  end

  private

  def self.valid_url?(url)
     !!(url =~ /\A#{URI::regexp}\z/)
  end

end
