-- Creating table for tracks
CREATE TABLE IF NOT EXISTS tracks
(
	track_id VARCHAR(25) PRIMARY KEY NOT NULL,
	track_name VARCHAR(255) NOT NULL,
	track_artist VARCHAR(255) NOT NULL,
	track_popularity SMALLINT,
	duration_ms BIGINT NOT NULL
);

-- Uploading table for tracks from local CSV
LOAD DATA INFILE "/var/lib/mysql-files/tracks.csv"
INTO TABLE tracks 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

-- Creating table for albums
CREATE TABLE IF NOT EXISTS albums
(
	album_id VARCHAR(25) PRIMARY KEY NOT NULL,
	album_name VARCHAR(255) NOT NULL,
	album_release_date DATE NOT NULL
);

-- Uploading table for albums from local CSV
LOAD DATA INFILE '/var/lib/mysql-files/albums.csv'
INTO TABLE albums 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Creating table for playlists
CREATE TABLE IF NOT EXISTS playlists
(
	playlist_id VARCHAR(25) PRIMARY KEY NOT NULL,
	playlist_name VARCHAR(255) NOT NULL,
	playlist_genre VARCHAR(255) NOT NULL,
    playlist_subgenre VARCHAR(255)
);

-- Uploading table for playlists from local CSV
LOAD DATA INFILE '/var/lib/mysql-files/playlists.csv'
INTO TABLE playlists 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

-- Creating table for tracks' characteristics
CREATE TABLE IF NOT EXISTS track_characteristics
(
	track_id VARCHAR(25) PRIMARY KEY NOT NULL,
	danceability DOUBLE NOT NULL,
	energy DOUBLE NOT NULL,
    key_ SMALLINT NOT NULL,
    loudness DOUBLE NOT NULL,
    mode SMALLINT NOT NULL,
    speechiness DOUBLE NOT NULL,
    acousticness DOUBLE NOT NULL,
    instrumentalness DOUBLE NOT NULL,
    liveness DOUBLE NOT NULL,
    valence DOUBLE NOT NULL,
    tempo DOUBLE NOT NULL,
    FOREIGN KEY (track_id) REFERENCES tracks(track_id) ON DELETE CASCADE
);

-- Uploading table for tracks' characteristics from local CSV
LOAD DATA INFILE '/var/lib/mysql-files/track_characteristics.csv'
INTO TABLE track_characteristics 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

CREATE INDEX idx_ch_track ON track_characteristics(track_id);

-- Creating table for track-to-album connection
CREATE TABLE IF NOT EXISTS track_to_album
(
	track_id VARCHAR(25) NOT NULL,
	album_id VARCHAR(25) NOT NULL,
    PRIMARY KEY (track_id, album_id),
    FOREIGN KEY (track_id) REFERENCES tracks(track_id) ON DELETE CASCADE,
    FOREIGN KEY (album_id) REFERENCES albums(album_id) ON DELETE CASCADE
);

-- Uploading table for track-to-album connection from local CSV
SET FOREIGN_KEY_CHECKS = 0;
LOAD DATA INFILE '/var/lib/mysql-files/track_to_album.csv'
INTO TABLE track_to_album
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

CREATE INDEX idx_ta_track ON track_to_album(track_id);
CREATE INDEX idx_ta_album ON track_to_album(album_id);

-- Creating table for track-to-playlist connection
CREATE TABLE IF NOT EXISTS track_to_playlist
(
	track_id VARCHAR(25) NOT NULL,
	playlist_id VARCHAR(25) NOT NULL,
    PRIMARY KEY (track_id, playlist_id),
    FOREIGN KEY (track_id) REFERENCES tracks(track_id) ON DELETE CASCADE,
    FOREIGN KEY (playlist_id) REFERENCES playlists(playlist_id) ON DELETE CASCADE
);

-- Uploading table for track-to-playlist connection from local CSV
LOAD DATA INFILE '/var/lib/mysql-files/track_to_playlist.csv'
INTO TABLE track_to_playlist
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

CREATE INDEX idx_tp_track ON track_to_playlist(track_id);
CREATE INDEX idx_tp_playlist ON track_to_playlist(playlist_id);