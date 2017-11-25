class SongsController < ApplicationController

  get '/songs' do
    @songs = Song.all
    erb :'/songs/index'
  end

  get '/songs/new' do
    @artists = Artist.all
    @genres = Genre.all
    erb :'/songs/new'
  end

  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    erb :'/songs/show'
  end

  post '/songs' do
    # binding.pry

    # Assigns Artists

    if params[:artist_id] != nil
      @artist = Artist.find(params[:artist_id])
    elsif !params[:artist_name].empty?
      @artist = Artist.create(name: params[:artist_name])
    else
      raise "ERROR, PLEASE ENTER AN ARTIST"
    end

    # Assigns Genres

    @genres = []

    # binding.pry

    if params[:genres] != nil
      params[:genres].each do |genre|
        @genres << Genre.find(genre.id)
      end
    end

    if !params[:genre_name].empty?
      @genres << Genre.create(name: params[:genre_name])
    end

    @song = Song.create(name: params[:name], artist: @artist)
    @genres.each do |genre|
      @song.genres << genre
    end
    @song.save

    binding.pry

    redirect "/songs/#{@song.slug}"
  end

end
