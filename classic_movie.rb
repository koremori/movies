# frozen_string_literal: true

class ClassicMovie < Movie
  COST = Money.from_amount(1.5, 'USD')
  def info
    "#{@title} - classical movie, dir. #{@director}"
  end
end
