# movie.rb
# frozen_string_literal: true

class Movie
  def initialize(db)
    @db = db
  end

  def print_movie
    result = @db.execute_query('SELECT title, year FROM movies')
    display_result(result)
  end

  private

  def display_result(result)
    # Выводим данные
    result.each do |row|
      puts row.values.join(', ')
    end
  end
end
