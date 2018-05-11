require 'pg'
require 'uri'
require_relative './database_connection'

class Bookmark

  attr_reader :title, :url, :id

  def initialize(options = {})
    @id = options["id"]
    @url = options["url"]
    @title = options["title"]
  end

  def ==(other)
    self.id == other.id
  end

end
