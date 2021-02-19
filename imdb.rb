# frozen_string_literal: true

require 'csv'
require 'ostruct'
require 'date'

def reading_file(file_path) #  =>  String
  default_path = '/home/koremori/documents/rubycode/movies.txt'
  File.exist?(file_path) ? File.read(file_path) : File.read(default_path)
end

def normalizing_movie_data(raw_data) # => multidimensional Array with Strings
  CSV.parse(raw_data, col_sep: '|')
end

def movie_to_ostruct(movies) # => Array with OpenStruct
  movies.map do |movie|
    OpenStruct.new(link: movie[0],
                   title: movie[1],
                   shoot_year: movie[2].to_i,
                   origin: movie[3],
                   release_date: normalizing_dates(movie[4]),
                   genre: movie[5],
                   duration: movie[6].to_i,
                   rating: rating_calculation(movie[7]),
                   director: movie[8],
                   cast: movie[9])
  end
end

def normalizing_dates(date)
  datemod = case date.size
            when 4
              "#{date}-01-01"
            when 7
              "#{date}-01"
            else
              date
            end
  Date.parse(datemod)
end

def finding_movies(movies, title)
  movies.select { |movie| movie[:title].include?(title) }
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
  movies.select { |movie| movie[:genre].include?(comedy) }
end

def sorted_by_origin(movies, country)
  movies.reject { |movie| movie[:origin].include?(country) }
end

def sorted_by_month(movies)
  movies.sort_by { |date| date[:release_date].mon }
end

def counted_by_months(movies)
  sorted_by_month(movies).each_with_object(Hash.new(0)) { |date, hash| hash[date[:release_date].strftime('%B')] += 1 }
end

def rating_calculation(rating)
  '*' * ((rating.to_f - 8) * 10).round
end

def render_movie(movie)
  puts "#{movie[:title]} #{movie[:rating]}"
end

def render_hash_movies(movie)
  puts "#{movie[:title]} (#{movie[:release_date]}; #{movie[:genre]}) - #{movie[:duration]} min"
end

def render_directors(movie)
  puts movie[:director].split.last
end

def render_with_dates(key, value)
  puts "#{key}: #{value}"
end

movies_data = reading_file(ARGV.first.to_s) # ARRAY -> string
movies_array = normalizing_movie_data(movies_data) # string -> array with subarrays
movies_struct = movie_to_ostruct(movies_array) # array with subarrays -> array with OpenStruct
year_sorted_struct = sorted_by_year(movies_struct)

puts "Movies which contain \"Max\" in title: \n"
finding_movies(movies_struct, 'Max').each { |movie| render_movie(movie) }

puts "5 longest movies: \n"
sorted_by_duration(movies_struct).first(5).each { |movie| render_hash_movies(movie) }

puts "10 comedies sorted by year: \n"
sorted_by_genre(year_sorted_struct, 'Comedy').first(10).each { |movie| render_hash_movies(movie) }

puts "Movies filmed outside USA: \n"
sorted_by_origin(year_sorted_struct, 'USA').each { |movie| render_hash_movies(movie) }

puts "All directors in alphabetic order: \n"
sorted_by_last_name(movies_struct).each { |movie| render_directors(movie) }

puts "Movies released overall in each month: \n"
counted_by_months(movies_struct).each { |key, value| render_with_dates(key, value) }
