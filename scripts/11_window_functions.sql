-- Window function
-- Ranking songs inside genres
SELECT p.playlist_genre, t.track_name, t.track_popularity,
    RANK() OVER (
        PARTITION BY p.playlist_genre
        ORDER BY t.track_popularity DESC
    ) AS genre_rank
FROM tracks AS t
JOIN track_to_playlist AS tp ON t.track_id = tp.track_id
JOIN playlists AS p ON tp.playlist_id = p.playlist_id;