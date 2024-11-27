CREATE TABLE IF NOT EXISTS Performer (
    id INTEGER PRIMARY KEY,
    alias VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS Album (
    id INTEGER PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    year_of_issue date NOT NULL
);

CREATE TABLE IF NOT EXISTS Track (
    id INTEGER PRIMARY KEY,
    album_id INTEGER REFERENCES Album(id) NOT NULL,
    title VARCHAR(255) NOT NULL,
    duration INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS MusicalGenre (
    id INTEGER PRIMARY KEY,
    title VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS Collections(
    id INTEGER PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    year_of_release date NOT NULL
);

CREATE TABLE IF NOT EXISTS Performer_MusicalGenre (
    id SERIAL PRIMARY KEY,
    performer_id INTEGER NOT NULL REFERENCES  Performer(id),
    musical_genre_id INTEGER NOT NULL REFERENCES  MusicalGenre(id)
);

CREATE TABLE IF NOT EXISTS Performer_Album (
    id SERIAL PRIMARY KEY,
    performer_id INTEGER NOT NULL REFERENCES  Performer(id),
    album_id INTEGER NOT NULL REFERENCES  Album(id)
);

CREATE TABLE IF NOT EXISTS Collections_Track (
    id SERIAL PRIMARY KEY,
    collection_id INTEGER NOT NULL REFERENCES  Collections(id),
    track_id INTEGER NOT NULL REFERENCES  Track(id)
);

INSERT INTO performer VALUES 
(1, 'Джон Райтл'),
(2, 'Эмма Полс'),
(3, 'Джейн Марблс'),
(4, 'Боб Скот'),
(5, 'Мерри');

INSERT INTO musicalgenre VALUES 
(1, 'Рок'),
(2, 'Хип хоп'),
(3, 'Реп');

INSERT INTO album VALUES 
(1, 'Милые капризы', '2020-12-17'),
(2, 'Последний день лета', '2003-05-12'),
(3, 'Осколки', '2023-11-03');

INSERT INTO track VALUES 
(1, 1, 'Старый солдат', '119'),
(2, 2,'Не мой', '123'),
(3, 3, 'Были и не были', '92'),
(4, 2, 'Алые рассветы', '612'),
(5, 3,'Розы', '127'),
(6, 1, 'Цветные сны', '98');

INSERT INTO collections VALUES 
(1, 'На прогулку', '2021-02-17'),
(2,'Танцевальные', '2020-06-01'),
(3, 'Для бокса', '2022-12-23'),
(4, 'Слушаем с дедом', '2023-11-03');

INSERT INTO collections_track VALUES 
(1, 1, 4),
(2, 2, 3),
(3, 3, 2),
(4, 4, 1),
(5, 4, 5),
(6, 2, 6),
(7, 3, 5);

INSERT INTO performer_album VALUES 
(1, 4, 1),
(2, 2, 2),
(3, 3, 3),
(4, 1, 3);

INSERT INTO performer_musicalgenre VALUES 
(1, 1, 1),
(2, 2, 3),
(3, 3, 2),
(4, 4, 2);
