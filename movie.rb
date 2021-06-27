# frozen_string_literal: true

require 'date'

# This class controls each specific field of information about each individual movie
class Movie

  require_relative 'ancient_movie'
  require_relative 'classic_movie'
  require_relative 'modern_movie'
  require_relative 'new_movie'

  attr_reader :link, :title, :shot, :origin, :premiere, :genre, :runtime, :rating, :director, :cast

  def initialize(movie)
    @link = movie[0]
    @title = movie[1]
    @shot = movie[2].to_i
    @origin = movie[3]
    @premiere = normalizing_dates(movie[4]).strftime('%B-%d-%Y')
    @genre = movie[5].split(',')
    @runtime = movie[6].to_i
    @rating = rating_calculation(movie[7])
    @director = movie[8]
    @cast = movie[9].split(',')
  end

  def has_genre?(genre)
    raise StandardError, "#{genre} not found!" unless self.genre.include?(genre)

    true
  end

  private

  def normalizing_dates(date)
    datemod = case date.size
              when 4
                "#{date}-01-01"
              when 7
                "#{date}-01"
              else
                date
              end
    Date.parse(datemod)
  end

  def rating_calculation(rating)
    '*' * ((rating.to_f - 8) * 10).round
  end
end
