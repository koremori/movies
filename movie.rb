# frozen_string_literal: true

require 'date'

# This class controls each specific field of information about each individual movie
class Movie
  attr_reader :link, :title, :shoot_year, :origin, :release_date, :genre, :duration, :rating, :director, :cast

  def initialize(movie)
    @link = movie[0]
    @title = movie[1]
    @shoot_year = movie[2].to_i
    @origin = movie[3]
    @release_date = normalizing_dates(movie[4])
    @genre = movie[5]
    @duration = movie[6].to_i
    @rating = rating_calculation(movie[7])
    @director = movie[8]
    @cast = movie[9]
  end

  def genre?(genre)
    case self.genre.include?(genre)
    when false
      puts "#{genre} is not on the list, try something else!"
    end
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
