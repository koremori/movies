# frozen_string_literal: true

require 'csv'

# This class controls inner behaviour of all movie list
class MovieCollection
  attr_reader :movies

  def initialize(file)
    @movies = CSV.read(file, col_sep: '|').map { |item| Movie.new(item) }
  end

  def all
    @movies
  end

  # By 'key' we can pass any global variable stated in 'class Movie' to sort stuff
  def sorted(key)
    if key == 'director'.to_sym
        all.map { |movies| movies.send(key.to_sym) }.sort.uniq # sorting the only case when output matches A LOT
    else
        all.map { |movies| movies.send(key.to_sym) }.sort
    end
  end

  def filtered(key, genre)
    all.map { |movies| movies.send(key.to_sym) }.select { |match| match.include?(genre) }
  end

  # ??????????
  def stats(key)
    directed = all.map { |movies| movies.send(key.to_sym) }.sort
    directed.inject(Hash.new(0)) { |total, e| total[e] += 1 } # ???????
    # directed.each_with_object(Hash.new(0)) { |graph, hash| hash[graph[@director]] += 1 }
  end
end
