-- SELECT + grouping (aka GROUP BY) + aggregation (aka COUNT):
-- How many songs each artist have in this table (in descending order)?
SELECT track_artist, COUNT(track_name) as n_songs FROM tracks
GROUP BY track_artist
ORDER BY n_songs DESC;