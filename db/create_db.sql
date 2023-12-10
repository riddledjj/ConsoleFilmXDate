
CREATE SCHEMA IF NOT EXISTS public;

CREATE TABLE IF NOT EXISTS movies
(
    id_film SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    year INTEGER
);


CREATE TABLE IF NOT EXISTS directors
(
    id_director SERIAL PRIMARY KEY,
    fullname TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS actors
(
    id_actor SERIAL PRIMARY KEY,
    fullname TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS directors_movies
(

    id_film INTEGER REFERENCES movies,
    id_director INTEGER REFERENCES directors,
    PRIMARY KEY (id_film, id_director)
);

CREATE TABLE IF NOT EXISTS actors_movies
(
    id_film INTEGER REFERENCES movies,
    id_actor INTEGER REFERENCES actors,
    PRIMARY KEY (id_film, id_actor)
)