require 'pg'
require 'uri'
require_relative './database_connection'

class Bookmark

  def self.create(id:, title:, url:)
    Bookmark.new(id: id.to_i, title: title, url: url)
  end

  def self.all
    result = DatabaseConnection.query("SELECT * FROM bookmarks")
    result.map { |row| create(id: row['id'], title: row['title'], url: row['url']) }
  end

  def self.add(url, title = nil)
    return false unless valid_url?(url)
    result = DatabaseConnection.query("INSERT INTO bookmarks (url, title) VALUES ('#{url}', '#{title}') RETURNING id, url, title;")
    create(id: result[0]['id'], title: result[0]['title'], url: result[0]['url'] )
  end

  def self.delete(id)
    DatabaseConnection.query("DELETE FROM bookmarks WHERE id=#{id}")
  end

  def self.find(title)
    result = DatabaseConnection.query("SELECT * FROM bookmarks WHERE title='#{title}'")
    result.map { |row| create(id: row['id'], title: row['title'], url: row['url'])}
  end

  def self.update(id:, title: nil, url: nil)
    DatabaseConnection.query("UPDATE bookmarks SET title='#{title}' WHERE id=#{id}") if title
    DatabaseConnection.query("UPDATE bookmarks SET url='#{url}' WHERE id=#{id}") if url
  end

  private

  def self.valid_url?(url)
     !!(url =~ /\A#{URI::regexp}\z/)
  end

  public

  attr_reader :title, :url, :id

  def initialize(id:, url:, title: nil)
    @id = id
    @url = url
    @title = title
  end

  def ==(other)
    self.id == other.id
  end

end
