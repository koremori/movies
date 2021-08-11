# frozen_string_literal: true

class ModernMovie < Movie
  COST = Money.from_amount(3, 'USD')
  def info
    "#{@title} - modern movie, starring: #{@cast.join(', ')}"
  end
end
