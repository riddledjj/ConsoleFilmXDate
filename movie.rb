class Movie
  attr_accessor :title, :release_year

  def initialize(title, release_year)
    @title = title
    @release_year = release_year
  end
end