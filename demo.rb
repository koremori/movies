# frozen_string_literal: true

require_relative 'movie'
require_relative 'movie_collection'

file = ARGV.first || 'movies.txt'

unless File.exist?(file)
  puts "File doesn't exist"
  exit
end

collection = MovieCollection.new(file)

p collection.all.map(&:link)
#puts collection.sorted(:cast) # <= and any other syms
#puts collection.filtered(:genre, 'Drama')
#puts collection.stats(:release_date)
#puts collection.all.genre.genre?('Tragedy')
