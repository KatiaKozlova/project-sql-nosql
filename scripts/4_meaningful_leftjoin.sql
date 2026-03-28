-- Meaningful LEFT JOIN
-- All songs without a playlist
SELECT t.track_name as tracks_without_playlists FROM tracks AS t
LEFT JOIN track_to_playlist AS tp ON t.track_id = tp.track_id
WHERE tp.playlist_id IS NULL;