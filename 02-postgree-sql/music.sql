CREATE TABLE IF NOT EXISTS Performer (
    id INTEGER PRIMARY KEY,
    alias VARCHAR(255) NOT NULL,
);

CREATE TABLE IF NOT EXISTS Album (
    id INTEGER PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    year_of_issue date NOT NULL,
);

CREATE TABLE IF NOT EXISTS Track (
    id INTEGER PRIMARY KEY,
    album_id INTEGER REFERENCES Album(id) NOT NULL,
    title VARCHAR(255) NOT NULL,
    duration INTEGER NOT NULL,
);

CREATE TABLE IF NOT EXISTS MusicalGenre (
    id INTEGER PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
);

CREATE TABLE IF NOT EXISTS Collections(
    id INTEGER PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    track_id INTEGER REFERENCES Track(id) NOT NULL,
    year_of_release date NOT NULL,
);

CREATE TABLE IF NOT EXISTS Performer_MusicalGenre (
    id SERIAL PRIMARY KEY,
    performer_id INTEGER NOT NULL REFERENCES  Performer(id),
    musical_genre_id INTEGER NOT NULL REFERENCES  MusicalGenre(id),
);

CREATE TABLE IF NOT EXISTS Performer_Album (
    id SERIAL PRIMARY KEY,
    performer_id INTEGER NOT NULL REFERENCES  Performer(id),
    album_id INTEGER NOT NULL REFERENCES  Album(id),
);

CREATE TABLE IF NOT EXISTS Collections_Track (
    id SERIAL PRIMARY KEY,
    collection_id INTEGER NOT NULL REFERENCES  Collections(id),
    track_id INTEGER NOT NULL REFERENCES  Track(id),
);
