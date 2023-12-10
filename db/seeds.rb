# Подключение ActiveRecord
require 'app/models/actor'
require 'app/models/director'
require 'app/models/movie'
require 'active_record'

# Подключение к базе данных
ActiveRecord::Base.establish_connection(
  adapter: 'postgresql',
  database: 'movie_catalog',
  username: 'user',
  password: 'password',
  host: 'localhost',
  port: 5432
)

# Определение модели Movie
class Movie < ActiveRecord::Base
end

# Create directors
christopher_nolan = Director.create(name: 'Кристофер Нолан')
quentin_tarantino = Director.create(name: 'Квентин Тарантино')
steven_spielberg = Director.create(name: 'Стивен Спилберг')

# Create actors
leonardo_dicaprio = Actor.create(name: 'Леонардо ДиКаприо')
margot_robbie = Actor.create(name: 'Марго Робби')
brad_pitt = Actor.create(name: 'Брэд Питт')
tom_hanks = Actor.create(name: 'Том Хэнкс')
scarlett_johansson = Actor.create(name: 'Скарлетт Йоханссон')

# Create movies
inception = Movie.create(title: 'Начало', year: 2010, director: christopher_nolan)
interstellar = Movie.create(title: 'Интерстеллар', year: 2014, director: christopher_nolan)
django_unchained = Movie.create(title: 'Однажды в Голливуде', year: 2019, director: quentin_tarantino)
pulp_fiction = Movie.create(title: 'Криминальное чтиво', year: 1994, director: quentin_tarantino)
saving_private_ryan = Movie.create(title: 'Испуганный рядовой Райан', year: 1998, director: steven_spielberg)
jurassic_park = Movie.create(title: 'Парк юрского периода', year: 1993, director: steven_spielberg)
once_upon_a_time_in_hollywood = Movie.create(title: 'Однажды в Голливуде', year: 2019, director: quentin_tarantino)
the_revenant = Movie.create(title: 'Выживший', year: 2015, director: alejandro_inarritu)
forrest_gump = Movie.create(title: 'Форрест Гамп', year: 1994, director: robert_zemeckis)
lost_in_translation = Movie.create(title: 'Трудности перевода', year: 2003, director: sofia_coppola)

# Create associations using unique IDs
MovieActor.create(movie_id: inception.id, actor_id: leonardo_dicaprio.id)
MovieActor.create(movie_id: inception.id, actor_id: tom_hardy.id)

MovieActor.create(movie_id: interstellar.id, actor_id: matthew_mcconaughey.id)
MovieActor.create(movie_id: interstellar.id, actor_id: anne_hathaway.id)

MovieActor.create(movie_id: django_unchained.id, actor_id: jamie_foxx.id)
MovieActor.create(movie_id: django_unchained.id, actor_id: christoph_waltz.id)

MovieActor.create(movie_id: pulp_fiction.id, actor_id: john_travolta.id)
MovieActor.create(movie_id: pulp_fiction.id, actor_id: uma_thurman.id)

MovieActor.create(movie_id: saving_private_ryan.id, actor_id: tom_hanks.id)
MovieActor.create(movie_id: saving_private_ryan.id, actor_id: matt_damon.id)

MovieActor.create(movie_id: jurassic_park.id, actor_id: sam_neill.id)
MovieActor.create(movie_id: jurassic_park.id, actor_id: laura_dern.id)

MovieActor.create(movie_id: once_upon_a_time_in_hollywood.id, actor_id: leonardo_dicaprio.id)
MovieActor.create(movie_id: once_upon_a_time_in_hollywood.id, actor_id: brad_pitt.id)

MovieActor.create(movie_id: the_revenant.id, actor_id: leonardo_dicaprio.id)
MovieActor.create(movie_id: the_revenant.id, actor_id: tom_hardy.id)

MovieActor.create(movie_id: forrest_gump.id, actor_id: tom_hanks.id)
MovieActor.create(movie_id: forrest_gump.id, actor_id: robin_wright.id)

MovieActor.create(movie_id: lost_in_translation.id, actor_id: bill_murray.id)
MovieActor.create(movie_id: lost_in_translation.id, actor_id: scarlett_johansson.id)
