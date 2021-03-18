class MovieCollection
  attr_reader :movies
  require '/home/koremori/Task_05/movie.rb'
  require 'csv'

  def initialize
    default_path = '/home/koremori/Task_05/movies.txt'
    raw_data = File.exist?(ARGV.first.to_s) ? File.read(ARGV.first.to_s) : File.read(default_path)
    @movies = CSV.parse(raw_data, col_sep: '|')
  end

 # def all
   # @movies.@title.sort
  #end

  def to_s
    "#{movies}"
  end

  def to_a
    [movies]
  end

  def filtered(key, input)
    @movies.sort_by { |item| item[key.to_sym].include?(input) }
  end

  def stats(key, input)
    movies.each_with_object(Hash.new(0)) { |item, hash| hash[item[key.to_sym]] += 1 }
  end
end
