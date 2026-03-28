-- CRUD
	-- Create aka INSERT
INSERT INTO tracks VALUES
	('52NczVizsfo25zI403QkdU', 'Seven', 'Andrew Animal', 100, 408512);
    -- Read aka SELECT
SELECT * FROM tracks
WHERE track_id = '52NczVizsfo25zI403QkdU';

	-- Update aka UPDATE
UPDATE tracks
SET track_name = 'Eight', track_artist = 'Andrew Bird'
WHERE track_id = '52NczVizsfo25zI403QkdU';
    -- Read aka SELECT
SELECT * FROM tracks
WHERE track_id = '52NczVizsfo25zI403QkdU';

	-- Delete aka DELETE
DELETE FROM tracks
WHERE track_id = '52NczVizsfo25zI403QkdU';
    -- Read aka SELECT
SELECT * FROM tracks
WHERE track_id = '52NczVizsfo25zI403QkdU';