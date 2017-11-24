# Add seed data here. Seed your database with `rake db:seed`

Song.destroy_all
Genre.destroy_all
Artist.destroy_all

@artist = Artist.create(name: "A$AP Rocky")
@genre = Genre.create(name: "Hip Hop & R&B")
@song = Song.create(name: "Wild for the Night", artist_id: @artist.id)
@song_genre = SongGenre.create(song_id: @song.id, genre_id: @genre.id)
