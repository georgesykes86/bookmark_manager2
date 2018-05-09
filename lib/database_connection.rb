class DatabaseConnection

  def self.query(query)
    if ENV['RACK_ENV'] == 'test'
      con = PG.connect :dbname => 'bookmark_manager_test'
    else
      con = PG.connect :dbname => 'bookmark_manager'
    end
    con.exec(query)
  end

  private_class_method :new
end
