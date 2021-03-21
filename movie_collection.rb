# frozen_string_literal: true

require 'csv'
require 'date'

# This class controls inner behaviour of all movie list
class MovieCollection
  attr_reader :movies

  def initialize(file)
    @movies = CSV.read(file, col_sep: '|').map { |item| Movie.new(item) }
  end

  def all
    @movies
  end

  # By 'key' we can pass any global variable stated in 'class Movie' to sort stuff
  def sorted(key)
    if key == 'director'.to_sym
      all.map { |movies| movies.send(key.to_sym) }.sort.uniq # sorting the only case when output matches A LOT
    else
      all.map { |movies| movies.send(key.to_sym) }.sort
    end
  end

  def filtered(key, genre)
    all.map { |movies| movies.send(key.to_sym) }.select { |match| match.include?(genre) }
  end

  def stats(key)
    if key == 'release_date'.to_sym
      all.map { |dates| dates.release_date.strftime('%B') }.tally
    elsif key == 'cast'.to_sym
      all.map { |actors| actors.cast.split(',') }.flatten.sort.tally
    elsif key == 'genre'.to_sym
      all.map { |genres| genres.genre.split(',') }.flatten.sort.tally
    else
      all.map { |movies| movies.send(key.to_sym) }.sort.tally
    end
  end
end
