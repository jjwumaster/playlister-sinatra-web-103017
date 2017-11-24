# require_relative '../../lib/helper_methods.rb'

class Genre < ActiveRecord::Base
  has_many :song_genres
  has_many :songs, through: :song_genres
  has_many :artists, through: :songs

  def self.find_by_slug(slug) # TAKE OUT OF SPEC
    self.all.find do |genre|
      genre.slug == slug
    end
  end

  def slug
    self.name.downcase.gsub!(/[\s\!\@\#\$\%\^\&\*\(\)\.]/,"-")
  end

end
