# frozen_string_literal: true

class Netflix < MovieCollection
  TIME = Time.now

  FILTER = { ancient: AncientMovie,
             classic: ClassicMovie,
             modern: ModernMovie,
             new: NewMovie }.freeze

  @@wallet = Cashbox::Cash.new.balance

  def pay(currency)
    @@wallet += Money.from_amount(currency, 'USD')
  end

  def take(who)
    case who
    when 'Bank'
      @@wallet *= 0
      puts 'Carried out encashment'
    else
      raise ArgumentError, 'Calling the police'
    end
  end

  def self.cash
    puts "Balance: #{@@wallet.format}"
  end

  def show(genre, period)
    choice = []
    choice << @movies.select { |movie| movie.genre.include?(genre) && FILTER[period] == movie.class }.sample
    raise StandardError, 'Insufficient funds' if @@wallet < choice.first.class::COST

    @@wallet -= choice.first.class::COST
    choice.each { |movie| render_output(movie) }
  end

  def how_much?(title)
    puts "#{title} costs: #{@movies.select { |movie| movie.title.include?(title) }.first.class::COST.format}"
  end

  private

  def render_output(movie)
    puts "Now showing: #{movie.info} (Start time: #{TIME.strftime('%H:%M')}, End time: #{(TIME + (movie.runtime * 60)).strftime('%H:%M')})"
  end
end
