# database_connector.rb
require 'sqlite3'

class DatabaseConnector
  DATABASE_FILE = 'moviedb.sqlite'

  def initialize
    @db = SQLite3::Database.new(DATABASE_FILE)
  end

  def execute(query, *params)
    @db.execute(query, params)
  end

  def get_first_value(query, *params)
    @db.get_first_value(query, params)
  end

  def close
    @db.close if @db
  end
end
