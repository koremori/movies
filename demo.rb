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
# movies.stats(:genre)
# p movies.all.first.has_genre?('Drama')
# netflix.how_much?('Metropolis')
# netflix.balance
# netflix.pay(20)
# netflix.show('Comedy', :new)
# netflix.show('Drama', :ancient)
# netflix.balance
# netflix.show('Comedy', :ancient)
# netflix.show('Adventure', :modern)
# netflix.balance
# netflix.show('Drama', :new)
# netflix.balance
# netflix.show('Comedy', :new)
# netflix.show('Comedy', :new)
# netflix.show('Comedy', :new)
# netflix.show('Comedy', :new)
# netflix.show('Comedy', :ancient)
# netflix.balance
# p netflix.all

p theatre.show('evening')
p theatre.show('morning')
p theatre.show('afternoon')
p theatre.when?('Mad Max')
p theatre.when?('The Thing')
p theatre.when?('Metropolis')
p theatre.when?('The Shawshank Redemption')