# frozen_string_literal: true

class NewMovie < Movie
  COST = Money.from_amount(5, 'USD')
  TIME = Time.now.year
  def info
    "#{@title} - new movie, released #{TIME - @shot} years ago!"
  end
end
