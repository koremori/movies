# frozen_string_literal: true

require_relative 'movie_collection'

class Theatre < MovieCollection
  TIME = Time.now

  def show(time)
    choice = []
    case time.capitalize
    when 'Morning'
      choice << @movies.select { |movie| movie.instance_of?(AncientMovie) }.sample
    when 'Afternoon'
      choice << @movies.select { |movie| movie.genre.include?('Adventure') }.sample
      choice << @movies.select { |movie| movie.genre.include?('Comedy') }.sample
    when 'Evening'
      choice << @movies.select { |movie| movie.genre.include?('Drama') }.sample
      choice << @movies.select { |movie| movie.genre.include?('Horror') }.sample
    end
    choice.each { |movie| render_output(movie) }
  end

  def when?(title)
    match = @movies.select { |movie| movie.title.include?(title) }
    if match.first.instance_of?(AncientMovie)
      puts "#{title} will be shown in the morning"
    elsif match.first.genre.include?('Comedy') || match.first.genre.include?('Adventure')
      puts "#{title} will be shown in the afternoon"
    elsif match.first.genre.include?('Drama') || match.first.genre.include?('Horror')
      puts "#{title} will be shown in the evening"
    end
  end

  def render_output(movie)
    puts "Now showing: #{movie.info}"
  end
end
