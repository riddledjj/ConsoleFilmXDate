class Actor
  def initialize(db)
    @db = db
  end

  def print_actor
    result = @db.execute_query('SELECT fullname FROM actors')
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
