# frozen_string_literal: true

require 'csv'

require_relative 'ancient_movie'
require_relative 'classic_movie'
require_relative 'modern_movie'
require_relative 'new_movie'

class MovieCollection
  MOVIE_CLASSES = { 1900..1945 => AncientMovie,
                    1945..1968 => ClassicMovie,
                    1968..2000 => ModernMovie,
                    2000..2021 => NewMovie }.freeze

  def initialize(file)
    @movies = CSV.read(file, col_sep: '|').map { |movie| class_mapper(movie[2]).new(movie) }
  end

  def all
    @movies
  end

  def sort_by(key)
    @movies.sort_by(&key).each { |movie| movie_info(movie) }
  end

  def filter(key, info)
    @movies.select { |movie| movie.send(key).include?(info) }.each { |movie| filter_render(movie) }
  end

  def stats(key)
    @movies.flat_map(&key).sort.tally.each { |info, stat| stat_render(info, stat) }
  end

  private

  def class_mapper(year)
    MOVIE_CLASSES.find { |key, _value| key.cover?(year.to_i) }.last
  end

  def stat_render(key, value)
    puts "#{key}: #{value}"
  end

  def filter_render(movie)
    puts "#{movie.title} - #{movie.genre.join(' ')} - #{movie.origin}"
  end

  def movie_info(movie)
    puts "#{movie.title} (#{movie.premiere}; #{movie.genre.join(' ')}) - #{movie.runtime} min; dir.#{movie.director}"
  end
end
