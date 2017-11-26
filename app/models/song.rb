# require_relative '../../lib/helper_methods.rb'

require 'rack-flash'
require "rack/flash/test"

class Song < ActiveRecord::Base
  belongs_to :artist
  has_many :song_genres
  has_many :genres, through: :song_genres

  def self.find_by_slug(slug) # TAKE OUT OF SPEC
    self.all.find do |song|
      song.slug == slug
    end
  end

  def slug
    self.name.downcase.gsub(/[\s\!\@\#\$\%\^\&\*\(\)\.]/,"-")
  end

end
