require 'yaml'
require 'pg'
require 'active_record'

# Загружаем настройки базы данных из файла
db_config = YAML.load(File.read(File.join(File.dirname(__FILE__), 'database.yml')))
environment = ENV['RACK_ENV'] || 'development'

# Устанавливаем соединение с базой данных
ActiveRecord::Base.establish_connection(db_config[environment])
