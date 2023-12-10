require_relative 'db/database'
require_relative 'app/movie'
require_relative 'app/actor'
require_relative 'app/director'

class App
  def initialize
    @db = Database.new
  end

  def start
    loop do

      puts '1. Список фильмов'
      puts '2. Список актеров'
      puts '3. Список режиссеров'

      choice = gets.chomp.to_i

      case choice
      when 1
        movie = Movie.new(@db)
        movie.print_movie
      when 2
        actor = Actor.new(@db)
        actor.print_actor
      when 3
        director = Director.new(@db)
        director.print_director
      when 3
        director = Director.new(@db)
        director.print_director

      else
        puts 'Неверный выбор'
      end
    end
  ensure
  end
end

app = App.new
app.start
