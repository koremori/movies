# frozen_string_literal: true

class ClassicMovie < Movie
  COST = 1.5
  def info
    "#{@title} - classical movie, dir. #{@director}"
  end
end
