# frozen_string_literal: true

require 'csv'

# This class controls inner behaviour of all movies in the list
class MovieCollection
  attr_reader :genre

  MOVIE_CLASSES = { 1900..1945 => AncientMovie,
                    1945..1968 => ClassicMovie,
                    1968..2000 => ModernMovie,
                    2000..2021 => NewMovie }.freeze

  def class_mapper(movie)
    MOVIE_CLASSES.select { |key, _value| key.cover?(movie.to_i) }
  end

  def initialize(file)
    @movies = CSV.read(file, col_sep: '|').map { |movie| class_mapper(movie[2]).values.first.new(movie) }
  end

  def all
    @movies
  end

  # By 'key' we can send any instance variable stated in 'class Movie' to sort stuff
  def sort_by(key)
    @movies.sort_by(&key).each { |movie| movie_info(movie) }
  end

  def filter(key, info)
    @movies.select { |movie| movie.send(key).include?(info) }.each { |movie| filter_render(movie) }
  end

  def stats(key)
    @movies.flat_map(&key).sort.tally.each { |info, stat| stat_render(info, stat) }
  end

  # Fancy output rendering methods
  def stat_render(key, value)
    puts "#{key}: #{value}"
  end

  def filter_render(movie)
    puts "#{movie.title} - #{movie.genre.join(' ')} - #{movie.origin}"
  end

  def movie_info(movie)
    puts "#{movie.title} (#{movie.release_date}; #{movie.genre.join(' ')}) - #{movie.duration} min; dir.#{movie.director}"
  end
end
