-- Not rewritable nested SELECT
-- The most popular song in an album (sorted by popularity)
SELECT a.album_name, t.track_name, t.track_popularity
FROM tracks AS t
JOIN track_to_album AS ta ON t.track_id = ta.track_id
JOIN albums AS a ON ta.album_id = a.album_id
WHERE t.track_popularity = (
    SELECT MAX(t2.track_popularity)
    FROM tracks AS t2
    JOIN track_to_album AS ta2 ON t2.track_id = ta2.track_id
    WHERE ta2.album_id = ta.album_id
)
ORDER BY t.track_popularity DESC;