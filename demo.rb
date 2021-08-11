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
Netflix.cash
netflix.pay(20)
netflix.show('Comedy', :new)
netflix.show('Drama', :ancient)
Netflix.cash
netflix.show('Comedy', :ancient)
netflix.show('Adventure', :modern)
Netflix.cash
netflix.show('Drama', :new)
Netflix.cash

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
Netflix.cash
theatre.cash
theatre.take('Bank')
theatre.cash
Netflix.cash
netflix2 = Netflix.new(file)
netflix2.pay(30)
Netflix.cash
netflix.take('Bank')
Netflix.cash
