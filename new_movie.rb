# frozen_string_literal: true

class NewMovie < Movie
  COST = 5
  def info
    "#{@title} - new movie, released #{2021 - @shoot_year} years ago!"
  end
end
