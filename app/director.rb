# director.rb
# frozen_string_literal: true

class Director
  def initialize(db)
    @db = db
  end

  def print_director
    result = @db.execute_query('SELECT directors.fullname, movies.title, movies.year FROM directors INNER JOIN movies.title ON directors.id = movies.director_id')
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
