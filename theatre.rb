# frozen_string_literal: true

require_relative 'movie_collection'

class Theatre < MovieCollection
  TIME = Time.now

  def show(time)
    choice = []
    case time
    when 'morning'
      choice << @movies.select { |movie| movie.instance_of?(AncientMovie) }.sample
    when 'afternoon'
      choice << @movies.select { |movie| movie.genre.include?('Comedy') || movie.genre.include?('Adventure') }.sample
    when 'evening'
      choice << @movies.select { |movie| movie.genre.include?('Drama') || movie.genre.include?('Horror') }.sample
    end
    choice.each { |movie| render_output(movie) }
  end

  def when?(title)
    match = @movies.select { |movie| movie.title.include?(title) }
    if match.first.instance_of?(AncientMovie)
      puts 'Morning'
    elsif match.first.genre.include?('Comedy') || match.first.genre.include?('Adventure')
      puts 'Afternoon'
    elsif match.first.genre.include?('Drama') || match.first.genre.include?('Horror')
      puts 'Evening'
    end
  end

  def render_output(movie)
    puts "Now showing: #{movie.info} (Start time: #{TIME.strftime('%H:%M')}, End time: #{(TIME + (movie.runtime * 60)).strftime('%H:%M')})"
  end
end
