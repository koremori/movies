require '/home/koremori/Task_05/movie_collection.rb'
require '/home/koremori/Task_05/movie.rb'

ass = MovieCollection.new
dick = ass.to_a
#cock = Movie.new(dick)


dick.each { |item| item.each { |elem| p elem[3] } }
