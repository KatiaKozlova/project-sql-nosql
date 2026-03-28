-- Nested SELECT + WITH
-- Songs that are more popular than the average in a playlist
WITH playlist_tracks AS (
    SELECT t.track_id, t.track_name, t.track_popularity, tp.playlist_id, p.playlist_name FROM tracks AS t
    JOIN track_to_playlist AS tp ON t.track_id = tp.track_id
    JOIN playlists AS p ON tp.playlist_id = p.playlist_id
)

SELECT pt.playlist_name, pt.track_name, pt.track_popularity FROM playlist_tracks AS pt
WHERE pt.track_popularity > (
    SELECT AVG(pt2.track_popularity) FROM playlist_tracks AS pt2
    WHERE pt2.playlist_id = pt.playlist_id
)
ORDER BY pt.playlist_name, pt.track_popularity DESC;