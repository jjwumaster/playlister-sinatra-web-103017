module Helpers
  def slug(name)
    name.downcase.gsub!(/[\s\!\@\#\$\%\^\&\*\(\)\.]/,"-")
  end

  def self.find_by_slug
    self.all.find do |inst|
      inst.name.slug = slug(self.name)
    end
  end

end
