require_relative './database_connection'
require_relative './bookmark'
require 'uri'

class DatabaseMapper

  def initialize(database_connection = DatabaseConnection, bookmark_class = Bookmark)
    @db_connection = database_connection
    @bookmark_class = bookmark_class
  end

  def all(object_class, table_name)
    result = @db_connection.query("SELECT * FROM #{table_name}")
    result.map { |tuple| object_class.new(tuple) }
  end

  def add_bookmark(url, title = nil)
    return false unless valid_url?(url)
    result = @db_connection.query("INSERT INTO bookmarks (url, title) VALUES ('#{url}', '#{title}') RETURNING id, url, title;")
    @bookmark_class.new(result.first)
  end

  def delete(id, table_name)
    @db_connection.query("DELETE FROM #{table_name} WHERE id=#{id}")
  end

  def find_bookmark(title)
    result = @db_connection.query("SELECT * FROM bookmarks WHERE title='#{title}'")
    result.map { |tuple| @bookmark_class.new(tuple) }
  end

  def update_bookmark(id, title , url)
    return false unless valid_url?(url)
    @db_connection.query("UPDATE bookmarks SET url='#{url}',title='#{title}' WHERE id=#{id}")
  end

  private

  def valid_url?(url)
    !!(url =~ /\A#{URI::regexp}\z/)
  end

end
