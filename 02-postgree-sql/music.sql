CREATE TABLE IF NOT EXISTS Performer {
    id INTEGER PRIMARY KEY,
    alias VARCHAR(255) NOT NULL,
};

CREATE TABLE IF NOT EXISTS Album {
    id INTEGER PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    year_of_issue date NOT NULL,
};

CREATE TABLE IF NOT EXISTS Track {
    id INTEGER PRIMARY KEY,
    album_id INTEGER REFERENCES Album(id) NOT NULL,
    title VARCHAR(255) NOT NULL,
    duration INTEGER NOT NULL,
};

CREATE TABLE IF NOT EXISTS MusicalGenre {
    id INTEGER PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
};

CREATE TABLE IF NOT EXISTS Collections{
    id INTEGER PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    track_id INTEGER REFERENCES Track(id) NOT NULL,
    year_of_release date NOT NULL,
};

CREATE TABLE IF NOT EXISTS Performer_MusicalGenre {
    id INTEGER PRIMARY KEY,
    performer_id INTEGER REFERENCES Performer(id) NOT NULL,
    musical_genre_id INTEGER REFERENCES MusicalGenre(id) NOT NULL,
};

CREATE TABLE IF NOT EXISTS Performer_Album {
    id INTEGER PRIMARY KEY,
    performer_id INTEGER REFERENCES Performer(id) NOT NULL,
    album_id INTEGER REFERENCES Album(id) NOT NULL,
};

CREATE TABLE IF NOT EXISTS Collections_Track {
    id INTEGER PRIMARY KEY,
    collection_id INTEGER REFERENCES Collections(id) NOT NULL,
    track_id INTEGER REFERENCES Track(id) NOT NULL,
};

