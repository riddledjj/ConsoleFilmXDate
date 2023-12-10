db_config = {
  host: 'localhost',
  port: 5432,
  dbname: 'postgres',
  user: 'vadym',
  password: '123'
}
@conn = PG.connect(db_config)