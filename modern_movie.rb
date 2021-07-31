# frozen_string_literal: true

class ModernMovie < Movie
  COST = 3
  def to_s
    "#{@title} - modern movie, starring: #{@cast.join(', ')}"
  end
end
