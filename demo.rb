# frozen_string_literal: true

require_relative 'movie'
require_relative 'movie_collection'

file = ARGV.first || 'movies.txt'

unless File.exist?(file)
  puts "File doesn't exist"
  exit
end

collection = MovieCollection.new(file)

puts collection.all.first(10).map(&:title)
puts collection.sorted(:cast) # <= and any other syms
puts collection.filtered(:genre, 'Drama')
# p collection.stats(:director)
