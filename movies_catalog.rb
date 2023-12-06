# movies_catalog.rb
require_relative 'database_connector'

def connect_to_database
  DatabaseConnector.new
end
# Метод для вывода каталога фильмов
def display_movies_catalog
  db = connect_to_database
  result = db.execute('SELECT * FROM Movies')

  result.each do |movie|
    puts "Фильм: #{movie[1]}, Год выпуска: #{movie[3]}"
    display_director_and_actors(movie[0])
    puts "------------------------"
  end

  db.close
end

# Метод для вывода связанных актеров и режиссера для конкретного фильма
def display_director_and_actors(movie_id)
  db = connect_to_database

  # Режиссер
  director_query = 'SELECT Directors.name FROM Directors
                    INNER JOIN MovieDirectors ON Directors.director_id = MovieDirectors.director_id
                    WHERE MovieDirectors.movie_id = ?'
  director = db.get_first_value(director_query, movie_id)
  puts "Режиссер: #{director}"

  # Актеры
  actors_query = 'SELECT Actors.name FROM Actors
                  INNER JOIN MovieActors ON Actors.actor_id = MovieActors.actor_id
                  WHERE MovieActors.movie_id = ?'
  actors = db.execute(actors_query, movie_id)
  puts "Актеры: #{actors.join(', ')}"

  db.close
end

# Метод для вывода списка связанных актеров и фильмов
def display_actors_catalog
  db = connect_to_database
  result = db.execute('SELECT * FROM Actors')

  result.each do |actor|
    puts "Актер: #{actor[1]}"
    display_movies_for_actor(actor[0])
    puts "------------------------"
  end

  db.close
end

# Метод для вывода фильмов, связанных с актером
def display_movies_for_actor(actor_id)
  db = connect_to_database

  movies_query = 'SELECT Movies.title, Movies.release_year FROM Movies
                  INNER JOIN MovieActors ON Movies.movie_id = MovieActors.movie_id
                  WHERE MovieActors.actor_id = ?'
  movies = db.execute(movies_query, actor_id)

  movies.each do |movie|
    puts "Фильм: #{movie[0]}, Год выпуска: #{movie[1]}"
  end

  db.close
end

# Метод для вывода списка режиссеров и связанных фильмов
def display_directors_catalog
  db = connect_to_database
  result = db.execute('SELECT * FROM Directors')

  result.each do |director|
    puts "Режиссер: #{director[1]}"
    display_movies_for_director(director[0])
    puts "------------------------"
  end

  db.close
end

# Метод для вывода фильмов, связанных с режиссером
def display_movies_for_director(director_id)
  db = connect_to_database

  movies_query = 'SELECT Movies.title, Movies.release_year FROM Movies
                  INNER JOIN MovieDirectors ON Movies.movie_id = MovieDirectors.movie_id
                  WHERE MovieDirectors.director_id = ?'
  movies = db.execute(movies_query, director_id)

  movies.each do |movie|
    puts "Фильм: #{movie[0]}, Год выпуска: #{movie[1]}"
  end

  db.close
end

# Основной блок кода
loop do
  puts "Выберите действие:"
  puts "1. Вывести каталог фильмов"
  puts "2. Вывести список актеров"
  puts "3. Вывести список режиссеров"
  puts "0. Выход"

  choice = gets.chomp.to_i

  case choice
  when 1
    display_movies_catalog
  when 2
    display_actors_catalog
  when 3
    display_directors_catalog
  when 0
    break
  else
    puts "Неверный выбор. Пожалуйста, введите корректный номер."
  end
end
