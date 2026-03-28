-- Nested SELECT:
-- Show name, artist and popularity of the speechful songs (>0.8).
SELECT track_name, track_artist, track_popularity FROM project.tracks AS t
WHERE t.track_id IN 
	(SELECT track_id FROM track_characteristics 
	WHERE speechiness > 0.8);