# frozen_string_literal: true

class AncientMovie < Movie
  COST = 1
  def to_s
    "#{@title} - ancient movie (#{@shot})"
  end
end
