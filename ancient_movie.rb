# frozen_string_literal: true

class AncientMovie < Movie
  COST = Money.from_amount(1, 'USD')
  def info
    "#{@title} - ancient movie (#{@shot})"
  end
end
