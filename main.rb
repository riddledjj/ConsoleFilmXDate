require 'pg'

class App
  def initialize
    db_config = {
      host: 'localhost',
      port: 5432,
      dbname: 'postgres',
      user: 'vadym',
      password: '123'
    }
    # Установите соединение с базой данных
    @conn = PG.connect(db_config)
  end

  def start
    puts '1. Список фильмов'
    puts '2. Список актеров'
    puts '3. Список режиссеров'

    choice = gets.chomp.to_i

    case choice
    when 1
      list_movies
    when 2
      list_actors_and_movies
    when 3
      list_directors_and_movies
    else
      puts 'Неверный выбор'
    end
  end

  private

  def list_movies
    result = @conn.exec('SELECT title``, year FROM movies')
    display_result(result)
  end

  def list_actors_and_movies
    result = @conn.exec('SELECT fullname FROM actors')
    display_result(result)
  end

  def list_directors_and_movies
    result = @conn.exec('SELECT fullname FROM directors')
    display_result(result)
  end

  def display_result(result)
    # Выводим заголовки столбцов
    puts result.fields.join(', ')

    # Выводим данные
    result.each do |row|
      puts row.values.join(', ')
    end
  end
end

app = App.new
app.start