# frozen_string_literal: true

class NewMovie < Movie
  COST = 5
  TIME = Time.now.year
  def info
    "#{@title} - new movie, released #{TIME - @shot} years ago!"
  end
end
