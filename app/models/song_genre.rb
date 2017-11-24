# require_relative '../../lib/helper_methods.rb'

class SongGenre < ActiveRecord::Base
  belongs_to :song
  belongs_to :genre
end
