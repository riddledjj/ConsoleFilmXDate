require 'dotenv/load'
require 'pg'

# test

class Database
 def initialize
  @conn = PG.connect(
    host: ENV['DB_HOST'],
    port: ENV['DB_PORT'],
    dbname: ENV['DB_NAME'],
    user: ENV['DB_USER'],
    password: ENV['DB_PASSWORD']
   )
  execute_query(File.read('db/create_db.sql'))
  execute_query(File.read('db/fill_db.sql'))

 end


 def execute_query(query)
  @conn.exec(query)
 end
end



class App
 def initialize
  @db = Database.new
 end

 def start
  result = @db.execute_query('SELECT title FROM movies')
  display_result(result)
 end

 def display_result(result)
  result.each do |row|
   puts "#{row['title']}"
  end

 end
end


App.new.start