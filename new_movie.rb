# frozen_string_literal: true

class NewMovie < Movie
  COST = 5
  def to_s
    "#{@title} - new movie, released #{2021 - @shot} years ago!"
  end
end
