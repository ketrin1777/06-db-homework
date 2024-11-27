SELECT mg.title, count(distinct performer_id) FROM performer_musicalgenre pm
left join musicalgenre mg on pm.musical_genre_id = mg.id
GROUP BY mg.title
ORDER BY COUNT(distinct performer_id) DESC;


SELECT c.title, count(distinct track_id) FROM collections_track ct
left join track t on ct.track_id = t.id
left join collections c on ct.collection_id = c.id
WHERE EXTRACT(YEAR FROM DATE(c.year_of_release)) between '2019' and '2020'
GROUP BY c.title;


SELECT c.title, AVG(t.duration) FROM collections_track ct
left join track t on ct.track_id = t.id
left join collections c on ct.collection_id = c.id
GROUP BY c.title;


SELECT p.alias FROM performer_album pa
left join album a on pa.album_id = a.id
left join performer p on pa.performer_id = p.id
WHERE EXTRACT(YEAR FROM DATE(a.year_of_issue)) != '2020'
GROUP BY p.alias;


SELECT c.title, p.alias FROM collections_track ct
left join collections c on ct.collection_id = c.id
left join track t on ct.track_id = t.id
left join album a on t.album_id = a.id
left join performer_album pa on a.id = pa.album_id
left join performer p on pa.performer_id = p.id
WHERE p.alias like '%Эмма Полс%'
GROUP BY c.title, p.alias;