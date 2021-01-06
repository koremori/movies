# frozen_string_literal: true

def reading_file(file_path)
  default_path = '/home/bunta/Documents/rubycode/movies.txt'
  File.exist?(file_path) ? File.read(file_path) : File.read(default_path)
end

def normalizing_movie_data(raw_data)
  raw_data.split("\n").map { |item| item.split('|') }
end

def movie_to_hash(movies)
  movies.map do |movie|
    {
      link: movie[0],
      title: movie[1],
      shoot_year: movie[2].to_i,
      origin_country: movie[3],
      release_date: movie[4],
      genre: movie[5],
      duration: movie[6].to_i,
      rating: rating_calculation(movie[7]),
      director: movie[8],
      cast: movie[9]
    }
  end
end

def finding_movies(movies_hash, title)
  movies_hash.select { |movie| movie[:title].include?(title) }
end

def sorted_by_duration(movies)
  movies.sort_by { |movie| movie[:duration] }.reverse
end

def sorted_by_year(movies)
  movies.sort_by { |movie| movie[:shoot_year] }
end

def sorted_by_last_name(movies)
  movies.sort_by { |movie| movie[:director].split.last }.uniq { |movie| movie[:director] }
end

def sorted_by_genre(movies, comedy)
  sorted_by_year(movies).select { |movie| movie[:genre].include?(comedy) }
end

def sorted_by_origin(movies, country)
  sorted_by_year(movies).reject { |movie| movie[:origin_country].include?(country) }
end

def render_movie(movie)
  puts "#{movie[:title]} #{movie[:rating]}"
end

def rating_calculation(rating)
  '*' * ((rating.to_f - 8) * 10).round
end

def render_hash_movies(movie)
  puts "#{movie[:title]} (#{movie[:release_date]}; #{movie[:genre]}) - #{movie[:duration]} min"
end

def render_directors(movie)
  puts movie[:director].split.last
end

movies_data = reading_file(ARGV.first.to_s) # ARRAY -> string
movies_array = normalizing_movie_data(movies_data) # string -> array with subarrays
movies_hash = movie_to_hash(movies_array) # array with subarrays -> array with hashes

finding_movies(movies_hash, 'Max').each { |movie| render_movie(movie) }

puts "5 longest movies: \n"
sorted_by_duration(movies_hash).first(5).each { |movie| render_hash_movies(movie) }

puts "10 comedies sorted by year: \n"
sorted_by_genre(movies_hash, 'Comedy').first(10).each { |movie| render_hash_movies(movie) }

puts "Movies filmed outside USA: \n"
sorted_by_origin(movies_hash, 'USA').each { |movie| render_hash_movies(movie) }

puts "All directors in alphabetic order: \n"
sorted_by_last_name(movies_hash).each { |movie| render_directors(movie) }
