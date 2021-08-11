# frozen_string_literal: true

class Netflix < MovieCollection
  attr_reader :wallet

  TIME = Time.now

  FILTER = { ancient: AncientMovie,
             classic: ClassicMovie,
             modern: ModernMovie,
             new: NewMovie }.freeze

  def initialize(file)
    super
    @wallet = 0
  end

  def pay(currency)
    @wallet += currency
  end

  def balance
    puts "Balance: #{@wallet}"
  end

  def show(genre, period)
    choice = []
    choice << @movies.select { |movie| movie.genre.include?(genre) && FILTER[period] == movie.class }.sample
    raise StandardError, 'Insufficient funds' if @wallet < choice.first.class::COST

    @wallet -= choice.first.class::COST
    choice.each { |movie| render_output(movie) }
  end

  def how_much?(title)
    puts "#{title} costs: #{@movies.select { |movie| movie.title.include?(title) }.first.class::COST}"
  end

  private

  def render_output(movie)
    puts "Now showing: #{movie.info} (Start time: #{TIME.strftime('%H:%M')}, End time: #{(TIME + (movie.runtime * 60)).strftime('%H:%M')})"
  end
end
