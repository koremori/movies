# frozen_string_literal: true

require_relative 'movie'
require_relative 'movie_collection'
require_relative 'netflix'
require_relative 'theatre'

file = ARGV.first || 'movies.txt'

unless File.exist?(file)
  puts "File doesn't exist"
  exit
end

movies = MovieCollection.new(file)
netflix = Netflix.new(file)
theatre = Theatre.new(file)

# movies.sort_by(:rating) # <= and any other keys
# movies.filter(:origin, 'Soviet Union')
movies.stats(:origin)
# p movies.all.first.has_genre?('Drama')

netflix.how_much?('Metropolis')
# netflix.balance
netflix.pay(20)
# netflix.show('Comedy', :new)
# netflix.show('Drama', :ancient)
netflix.balance
netflix.show('Comedy', :ancient)
netflix.show('Adventure', :modern)
netflix.balance
netflix.show('Drama', :new)
netflix.balance

theatre.show(22)
theatre.show(7)
theatre.show(14)
theatre.when?('Mad Max')
theatre.when?('Metropolis')
theatre.when?('The Thing')
theatre.when?('Dr. Strangelove or: How I Learned to Stop Worrying and Love the Bomb')
theatre.when?('Anatomy of a Murder')
p movies.count
p movies.first
p netflix.first
p theatre.first(2)
