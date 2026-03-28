-- PROCEDURE
-- Adding track with album and (optionally) playlist 
DELIMITER $$

CREATE PROCEDURE add_track_full(
	IN p_track_id VARCHAR(25),
    IN p_track_name VARCHAR(255),
    IN p_track_artist VARCHAR(255),
    IN p_track_popularity SMALLINT,
    IN p_duration_ms BIGINT,
    IN p_album_id VARCHAR(25),
    IN p_playlist_id VARCHAR(25)
)
BEGIN
    DECLARE v_track_id INT;
    -- Check if exists
    SELECT track_id INTO v_track_id FROM tracks
    WHERE track_id = p_track_id
    LIMIT 1;

    -- If not, create
    IF v_track_id IS NULL THEN
        INSERT INTO tracks (track_id, track_name, track_artist, track_popularity, duration_ms)
        VALUES (p_track_id, p_track_name, p_track_artist, p_track_popularity, p_duration_ms);
        
    END IF;

    -- Add link to album
    IF NOT EXISTS (
        SELECT 1 FROM track_to_album
        WHERE track_id = p_track_id AND album_id = p_album_id
    ) THEN
        INSERT INTO track_to_album (track_id, album_id)
        VALUES (p_track_id, p_album_id);
    END IF;

    -- Add link to playlist (if exists)
    IF p_playlist_id IS NOT NULL THEN
        IF NOT EXISTS (
            SELECT 1 FROM track_to_playlist
            WHERE track_id = p_track_id AND playlist_id = p_playlist_id
        ) THEN
            INSERT INTO track_to_playlist (track_id, playlist_id)
            VALUES (p_track_id, p_playlist_id);
        END IF;
    END IF;

END $$

DELIMITER ;