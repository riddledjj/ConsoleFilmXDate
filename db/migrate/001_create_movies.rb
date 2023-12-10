require 'active_record'
require 'actor'
require 'director'
require 'movie'


# Настройка подключения к базе данных
ActiveRecord::Base.establish_connection(
  adapter: 'postgresql',
  host: 'localhost',
  database: 'movie_catalog',
  name: 'name',
  password: 'password'
)

# Определение класса для миграции
class CreateYourTableName < ActiveRecord::Migration[6.0] # Версия ActiveRecord может отличаться

  def up
    create_table :your_table_name do |t|
      t.string :title
      t.integer :year
      # Автоматически добавится поле 'id' типа SERIAL
    end
  end

  def down
    drop_table :movies
  end

end

# Запуск миграции
CreateYourTableName.new.up
