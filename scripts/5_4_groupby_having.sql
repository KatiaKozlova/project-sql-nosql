-- Aggregation with HAVING
-- Albums with more than 10 songs
SELECT a.album_name, COUNT(ta.track_id) AS n_tracks FROM albums AS a
JOIN track_to_album AS ta ON a.album_id = ta.album_id
GROUP BY a.album_id
HAVING COUNT(ta.track_id) > 10;