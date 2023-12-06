require_relative 'person'
require_relative 'database_connector'
require_relative 'movie'
require_relative 'director'
require_relative 'actor'

class MovieCatalog
  def initialize
    @db = DatabaseConnector.new
  end

  def display_movies_catalog
    movies = @db.execute('SELECT * FROM Movies').map do |movie_data|
      Movie.new(movie_data[1], movie_data[3])
    end

    movies.each do |movie|
      puts "Фильм: #{movie.title}, Год выпуска: #{movie.release_year}"
      display_director_and_actors(movie)
      puts "------------------------"
    end
  end

  def display_director_and_actors(movie)
    director = find_director(movie)
    puts "Режиссер: #{director.name}" if director

    actors = find_actors(movie)
    puts "Актеры: #{actors.map(&:name).join(', ')}" if actors.any?
  end

  def display_actors_catalog
    actors = @db.execute('SELECT * FROM Actors').map { |actor_data| Actor.new(actor_data[1]) }

    actors.each do |actor|
      puts "Актер: #{actor.name}"
      display_movies_for_actor(actor)
      puts "------------------------"
    end
  end

  def display_movies_for_actor(actor)
    movies = find_movies_for_actor(actor)
    movies.each do |movie|
      puts "Фильм: #{movie.title}, Год выпуска: #{movie.release_year}"
    end
  end

  def display_directors_catalog
    directors = @db.execute('SELECT * FROM Directors').map { |director_data| Director.new(director_data[1]) }

    directors.each do |director|
      puts "Режиссер: #{director.name}"
      display_movies_for_director(director)
      puts "------------------------"
    end
  end

  def display_movies_for_director(director)
    movies = find_movies_for_director(director)
    movies.each do |movie|
      puts "Фильм: #{movie.title}, Год выпуска: #{movie.release_year}"
    end
  end

  private

  def find_director(movie)
    director_query = 'SELECT Directors.name FROM Directors
                      INNER JOIN MovieDirectors ON Directors.director_id = MovieDirectors.director_id
                      WHERE MovieDirectors.movie_id = ?'
    director_name = @db.get_first_value(director_query, movie_id(movie))
    Director.new(director_name) if director_name
  end

  def find_actors(movie)
    actors_query = 'SELECT Actors.name FROM Actors
                    INNER JOIN MovieActors ON Actors.actor_id = MovieActors.actor_id
                    WHERE MovieActors.movie_id = ?'
    @db.execute(actors_query, movie_id(movie)).map { |actor_data| Actor.new(actor_data[0]) }
  end

  def find_movies_for_actor(actor)
    movies_query = 'SELECT Movies.title, Movies.release_year FROM Movies
                    INNER JOIN MovieActors ON Movies.movie_id = MovieActors.movie_id
                    WHERE MovieActors.actor_id = ?'
    movie_data = @db.execute(movies_query, actor_id(actor))
    movie_data.map { |data| Movie.new(data[0], data[1]) }
  end

  def find_movies_for_director(director)
    movies_query = 'SELECT Movies.title, Movies.release_year FROM Movies
                    INNER JOIN MovieDirectors ON Movies.movie_id = MovieDirectors.movie_id
                    WHERE MovieDirectors.director_id = ?'
    movie_data = @db.execute(movies_query, director_id(director))
    movie_data.map { |data| Movie.new(data[0], data[1]) }
  end

  def actor_id(actor)
    @db.get_first_value('SELECT actor_id FROM Actors WHERE name = ?', actor.name)
  end

  def movie_id(movie)
    @db.get_first_value('SELECT movie_id FROM Movies WHERE title = ? AND release_year = ?', movie.title, movie.release_year)
  end

  def director_id(director)
    @db.get_first_value('SELECT director_id FROM Directors WHERE name = ?', director.name)
  end
end

# main.rb
movie_catalog = MovieCatalog.new

loop do
  puts "Выберите действие:"
  puts "1. Вывести каталог фильмов"
  puts "2. Вывести список актеров"
  puts "3. Вывести список режиссеров"
  puts "0. Выход"

  choice = gets.chomp.to_i

  case choice
  when 1
    movie_catalog.display_movies_catalog
  when 2
    movie_catalog.display_actors_catalog
  when 3
    movie_catalog.display_directors_catalog
  when 0
    break
  else
    puts "Неверный выбор. Пожалуйста, введите корректный номер."
  end
end
