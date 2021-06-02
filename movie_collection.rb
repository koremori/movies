# frozen_string_literal: true

require 'csv'

# This class controls inner behaviour of all movies in the list
class MovieCollection
  attr_reader :movies, :genre

  def initialize(file)
    @movies = CSV.read(file, col_sep: '|').map { |movie| Movie.new(movie) }
  end

  def all
    @movies
  end

  def genre?(genre)
     unless all.map(&:genre).include?(genre)
       puts "#{genre} is not in the list, try something else!"
     else puts 'Yes'
     end
  end

  # By 'key' we can send any instance variable stated in 'class Movie' to sort stuff
  def sort_by(key)
    all.sort_by(&key).each { |movie| movie_info(movie) }
  end

  def filter(key, info)
    all.select { |movie| movie.send(key).include?(info) }.each { |movie| filter_render(movie) }
  end

  def stats(key)
    case key.to_s
    when 'release_date'
      all.map { |dates| dates.release_date.strftime('%B') }.tally
         .each { |info, stat| stat_render(info, stat) }
    when 'cast'
      all.map { |actors| actors.cast.split(',') }.flatten.sort.tally
         .each { |info, stat| stat_render(info, stat) }
    when 'genre'
      all.map { |genres| genres.genre.split(',') }.flatten.sort.tally
         .each { |info, stat| stat_render(info, stat) }
    else
      all.map(&key).sort.tally
         .each { |info, stat| stat_render(info, stat) }
    end
  end

  # Fancy output rendering methods
  def stat_render(key, value)
    puts "#{key}: #{value}"
  end

  def filter_render(movie)
    puts "#{movie.send(:title)} - #{movie.send(:genre)} - #{movie.send(:origin)}"
  end

  def movie_info(movie)
    puts "#{movie.send(:title)} (#{movie.send(:release_date)}; #{movie.send(:genre)}) - #{movie.send(:duration)} min; dir.#{movie.send(:director)}"
  end

end
