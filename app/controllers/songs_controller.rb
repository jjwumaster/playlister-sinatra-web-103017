require 'rack-flash'

class SongsController < ApplicationController

  use Rack::Flash

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

  get '/songs/:slug/edit' do
    @song = Song.find_by_slug(params[:slug])
    @artists = Artist.all
    @genres = Genre.all
    erb :'/songs/edit'
  end

  post '/songs/:slug' do

    # Assigns Artists

    if params[:artist_id] != nil
      @artist = Artist.find(params[:artist_id])
    elsif !params[:artist_name].empty?
      if Artist.all.any? {|artist| artist.name == params["Artist Name"]}
        @artist = Artist.find(name: params["Artist Name"])
      else
        @artist = Artist.create(name: params["Artist Name"])
      end
    else
      raise "ERROR, PLEASE ENTER AN ARTIST"
    end

    # Assigns Genres

    @genres = []

    if params[:genre_ids] != nil
      params[:genre_ids].each do |genre_id|
        @genres << Genre.find(genre_id)
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

    flash[:message] = "Successfully updated song."

    redirect "/songs/#{@song.slug}"
  end

  post '/songs' do
    # binding.pry

    # Assigns Artists

    if params[:artist_id] != nil
      @artist = Artist.find(params[:artist_id])
    elsif !params[:artist_name].empty?
      if Artist.all.any? {|artist| artist.name == params[:artist_name]}
        @artist = Artist.find(name: params[:artist_name])
      else
        @artist = Artist.create(name: params[:artist_name])
      end
    else
      raise "ERROR, PLEASE ENTER AN ARTIST"
    end

    # Assigns Genres

    @genres = []

    if params[:genre_ids] != nil
      params[:genre_ids].each do |genre_id|
        @genres << Genre.find(genre_id)
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

    flash[:message] = "Successfully created song."

    redirect "/songs/#{@song.slug}"
  end

end
