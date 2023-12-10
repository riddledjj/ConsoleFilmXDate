CREATE SCHEMA IF NOT EXISTS public;

CREATE TABLE IF NOT EXISTS movies
(
    id SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    year INTEGER
);


CREATE TABLE IF NOT EXISTS directors
(
    id SERIAL PRIMARY KEY,
    fullname TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS actors
(
    id SERIAL PRIMARY KEY,
    fullname TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS directors_movies
(

    movie_id INTEGER REFERENCES movies,
    director_id INTEGER REFERENCES directors,
    PRIMARY KEY (movie_id, director_id)
);

CREATE TABLE IF NOT EXISTS actors_movies
(
    movie_id INTEGER REFERENCES movies,
    actor_id INTEGER REFERENCES actors,
    PRIMARY KEY (movie_id, actor_id)
)