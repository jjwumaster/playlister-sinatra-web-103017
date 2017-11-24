require_relative '../../lib/helper_methods.rb'

class Artist < ActiveRecord::Base

  # include Helpers

  has_many :songs
  has_many :genres, through: :songs

  def self.find_by_slug(slug) # TAKE OUT OF SPEC
    self.all.find do |artist|
      artist.slug == slug
    end
  end

  def slug
    self.name.downcase.gsub!(/[\s\!\@\#\$\%\^\&\*\(\)\.]/,"-")
  end

end
