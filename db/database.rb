require 'pg'

class Database
  def initialize
    db_config = {
      host: 'localhost',
      port: 5432,
      dbname: 'postgres',
      user: 'vadym',
      password: '123'
    }
    # Устанавливаем соединение с базой данных
    @conn = PG.connect(db_config)
  end

  def execute_query(query)
    @conn.exec(query)
  end

  def close_connection
    @conn.close if @conn
  end
end
