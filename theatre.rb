# frozen_string_literal: true

require_relative 'movie_collection'

class Theatre < MovieCollection
  TIME = Time.now

  def genre_matching(movie, genre)
    movie.genre.include?(genre)
  end

  def show(time)
    choice = []
    case time
    when 6..12
      choice << @movies.select { |movie| movie.is_a?(AncientMovie) }.sample
    when 12..18
      choice << @movies.select { |movie| !movie.is_a?(AncientMovie) && genre_matching(movie, 'Adventure') || genre_matching(movie, 'Comedy') }.sample
    else
      choice << @movies.select { |movie| !movie.is_a?(AncientMovie) && genre_matching(movie, 'Drama') || genre_matching(movie, 'Horror') }.sample
    end
    choice.each { |movie| render_output(movie) }
  end

  #def when?(title)
  #  p match = @movies.select { |movie| movie.title.include?(title) }
  #  if match.first.genre.include?('Adventure') && !match.first.is_a?(AncientMovie)
  #    puts "#{title} will be shown in the afternoon"
  #  elsif match.first.genre.include?('Comedy') && !match.first.is_a?(AncientMovie)
  #    puts "#{title} will be shown in the afternoon"
  #  elsif match.first.genre.include?('Drama') && !match.first.is_a?(AncientMovie)
  #    puts "#{title} will be shown in the evening"
  #  elsif match.first.genre.include?('Horror') && !match.first.is_a?(AncientMovie)
  #    puts "#{title} will be shown in the evening"
  #  elsif match.first.is_a?(AncientMovie)
  #    puts "#{title} will be shown in the morning"
  #  else
  #    puts "#{title}"
  #  end
  #end

  def when?(title)
    match = @movies.select { |movie| movie.title.include?(title) }
    case match.first
    when AncientMovie
      puts "#{title} will be shown in the morning"
    else
      if genre_matching(match.first, 'Adventure') || genre_matching(match.first, 'Comedy')
        puts "#{title} will be shown in the afternoon"
      elsif genre_matching(match.first, 'Horror') || genre_matching(match.first, 'Drama')
        puts "#{title} will be shown in the evening"
      end
    end
  end

  def render_output(movie)
    puts "Now showing: #{movie.info}"
  end
end
