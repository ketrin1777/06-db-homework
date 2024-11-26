SELECT title, duration FROM track
WHERE duration = (SELECT MAX(duration) FROM track);

SELECT title, duration FROM track
WHERE duration >= 3*60+5;

SELECT title FROM collections
WHERE EXTRACT(YEAR FROM DATE(year_of_release)) between '2018' and '2020';

SELECT alias FROM performer
WHERE alias !~ '[ \t\v\b\r\n\u00a0]';

SELECT title FROM track
WHERE title LIKE '%мой%' OR  title LIKE '%my%';

