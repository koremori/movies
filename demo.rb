# frozen_string_literal: true

require_relative 'movie'
require_relative 'movie_collection'

file = ARGV.first || 'movies.txt'

unless File.exist?(file)
  puts "File doesn't exist"
  exit
end

movies = MovieCollection.new(file)

movies.sort_by(:origin) # <= and any other keys
movies.filter(:origin, 'Soviet Union')
movies.stats(:cast)
p movies.all.first.has_genre?('Tragedy')
