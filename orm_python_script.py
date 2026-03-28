"""Simple CLI to interact with the DB via SQLAlchemy ORM."""

import os
from sqlalchemy import create_engine, Column, String, Integer, ForeignKey, or_
from sqlalchemy.orm import declarative_base, relationship, sessionmaker
from dotenv import load_dotenv

# Initialize DB connection
load_dotenv()
MYSQL_PASSWORD = os.getenv("MYSQL_PASSWORD")
DATABASE_URL = f"mysql+pymysql://root:{MYSQL_PASSWORD}@127.0.0.1:3306/project_kozlova"

engine = create_engine(DATABASE_URL, echo=False)
SessionLocal = sessionmaker(bind=engine)
Base = declarative_base()


class Track(Base):
    '''ORM model for the tracks table.'''
    __tablename__ = "tracks"
    track_id = Column(String(25), primary_key=True)
    track_name = Column(String(255), nullable=False)
    track_artist = Column(String(255), nullable=False)
    track_popularity = Column(Integer)
    duration_ms = Column(Integer, nullable=False)

    playlists = relationship("TrackToPlaylist", back_populates="track")


class Playlist(Base):
    '''ORM model for the playlists table.'''
    __tablename__ = "playlists"
    playlist_id = Column(String(25), primary_key=True)
    playlist_name = Column(String(255), nullable=False)
    playlist_genre = Column(String(255), nullable=False)
    playlist_subgenre = Column(String(255))

    tracks = relationship("TrackToPlaylist", back_populates="playlist")


class TrackToPlaylist(Base):
    '''ORM model for the track_to_playlist table.'''
    __tablename__ = "track_to_playlist"
    track_id = Column(
        String(25), ForeignKey("tracks.track_id"), primary_key=True
        )
    playlist_id = Column(
        String(25), ForeignKey("playlists.playlist_id"), primary_key=True
        )

    track = relationship("Track", back_populates="playlists")
    playlist = relationship("Playlist", back_populates="tracks")


class MusicService:
    '''Service class to interact with the database.'''
    def __init__(self):
        self.session = SessionLocal()

    def get_tracks_by_genre(self, genre: str) -> list[Track]:
        '''Returns a list of 10 tracks that belong to the specified (sub)genre.'''
        return (
            self.session.query(Track).join(TrackToPlaylist).join(Playlist)
            .filter(or_(
                Playlist.playlist_genre == genre,
                Playlist.playlist_subgenre == genre
                ))
            .limit(10).all()
        )

    def get_top_tracks(self, limit: int = 5) -> list[Track]:
        ''''Returns a list of the top-n tracks by popularity.'''
        return (
            self.session.query(Track)
            .order_by(Track.track_popularity.desc()).limit(limit).all()
        )

    def add_track_to_playlist(self, track_id: str, playlist_id: str):
        '''Adds a track to a playlist.'''
        exists = (
            self.session.query(TrackToPlaylist)
            .filter_by(track_id=track_id, playlist_id=playlist_id)
            .first()
        )

        if not exists:
            relation = TrackToPlaylist(
                track_id=track_id,
                playlist_id=playlist_id
            )
            self.session.add(relation)
            self.session.commit()
        else:
            print("Track already exists in the playlist!")

    def close(self):
        '''Closes the database session.'''
        self.session.close()


def main():
    '''Main function to run the CLI.'''
    service = MusicService()

    print("1 to search by genre")
    print("2 to view top-n tracks")
    print("3 to add track to playlist\n")
    selection = input("Enter selection: ")
    if selection == "1":
        # Choose genre to search for and print the results
        genre = input("Enter genre: ").lower()
        tracks = service.get_tracks_by_genre(genre)

        print("\nTracks found:")
        for t in tracks:
            print(f"{t.track_artist} - {t.track_name}")

    elif selection == "2":
        # Choose n for top-n tracks, or skip to get the default top-5
        top_n = input("Enter n or skip: ")
        if top_n == '':
            top_tracks = service.get_top_tracks()
        else:
            top_tracks = service.get_top_tracks(limit=int(top_n))

        for t in top_tracks:
            print(f"{t.track_artist} - {t.track_name} ({t.track_popularity})")

    elif selection == "3":
        # Choose track_id and playlist_id to add the track to the playlist
        track_id = input("\nEnter track_id to add: ")
        playlist_id = input("Enter playlist_id: ")

        service.add_track_to_playlist(track_id, playlist_id)

    else:
        # Invalid selection
        print("Invalid selection!")

    service.close()


if __name__ == "__main__":
    main()
