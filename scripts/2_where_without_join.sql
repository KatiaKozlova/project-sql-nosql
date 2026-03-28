-- WHERE joining without JOIN
-- Show track, artist and album (last 50)
SELECT t.track_name, t.track_artist, a.album_name
FROM tracks AS t, albums AS a, track_to_album AS ta
WHERE t.track_id = ta.track_id AND ta.album_id = a.album_id
ORDER BY track_name DESC
LIMIT 50;