# frozen_string_literal: true

class AncientMovie < Movie
  COST = 1
  def info
    "#{@title} - ancient movie (#{@shoot_year})"
  end
end
