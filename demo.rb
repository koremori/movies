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

# movies.sort_by(:origin) # <= and any other keys
movies.filter(:origin, 'Soviet Union')
# movies.stats(:origin)
p movies.all.first.has_genre?('Drama')
netflix.how_much?('Metropolis')
p netflix.wallet
p netflix.pay(20)
netflix.show('Comedy', :new)
netflix.show('Drama', :ancient)
p netflix.wallet
netflix.show('Comedy', :ancient)
netflix.show('Adventure', :modern)
p netflix.wallet
netflix.show('Drama', :new)
p netflix.wallet
# netflix.show('Comedy', :new)
# netflix.show('Comedy', :new)
# netflix.show('Comedy', :new)
# netflix.show('Comedy', :new)
netflix.show('Comedy', :ancient)
p netflix.wallet

theatre.show('morning')
theatre.when?('Alien')
