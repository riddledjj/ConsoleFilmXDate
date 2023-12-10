require 'dotenv/load'
require 'pg'
require 'pry'

class Database
 def connection
  @connection ||= PG.connect(
    host: ENV['DB_HOST'],
    port: ENV['DB_PORT'],
    dbname: ENV['DB_NAME'],
    user: ENV['DB_USER'],
    password: ENV['DB_PASSWORD']
  )
 end

 def fill_db
  connection.exec(File.read('db/fill_db.sql'))
 end

 def create_db
  connection.exec(File.read('db/create_db.sql'))
 end
end

class App
 def initialize(connection)
  @connection = connection
 end

 def movie_titles
  begin
   @connection.exec('SELECT title FROM movies')
  rescue StandardError => e
   p e
  end
 end

 def display_result(result)
  result.each do |row|
   puts "#{row['title']}"
  end
 end
end

db = Database.new
db.create_db
db.fill_db

app = App.new(db.connection)
app.display_result(app.movie_titles)
