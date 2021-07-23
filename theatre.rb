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

  def when?(title)
    match = @movies.select { |movie| movie.title.include?(title) }
    case match.first
    when AncientMovie
      time = 'morning'
    else
      if genre_matching(match.first, 'Adventure') || genre_matching(match.first, 'Comedy')
        time = 'afternoon'
      elsif genre_matching(match.first, 'Horror') || genre_matching(match.first, 'Drama')
        time = 'evening'
      end
    end
    puts "#{title} will be shown in the #{time}"
  end

  def render_output(movie)
    puts "Now showing: #{movie.info}"
  end
end
