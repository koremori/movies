# frozen_string_literal: true

class Theatre < MovieCollection
  def initialize(file)
    super
    @cashbox = Cashbox::Cash.new
  end

  def show(time)
    choice = []
    case time
    when 6..12
      choice << @movies.select { |movie| movie.is_a?(AncientMovie) }.sample
      buy_ticket(3)
    when 12..18
      choice << @movies.select { |movie| !movie.is_a?(AncientMovie) && genre_matching(movie, 'Adventure') || genre_matching(movie, 'Comedy') }.sample
      buy_ticket(5)
    else
      choice << @movies.select { |movie| !movie.is_a?(AncientMovie) && genre_matching(movie, 'Drama') || genre_matching(movie, 'Horror') }.sample
      buy_ticket(10)
    end
    purchase_render(choice.first.title)
    choice.each { |movie| render_output(movie) }
  end

  def when?(title)
    match = @movies.select { |movie| movie.title.include?(title) }
    time = case match.first
           when AncientMovie
             'morning'
           else
             if genre_matching(match.first, 'Adventure') || genre_matching(match.first, 'Comedy')
               'afternoon'
             elsif genre_matching(match.first, 'Horror') || genre_matching(match.first, 'Drama')
               'evening'
             else
               'shadow realm'
             end
           end
    puts "'#{title}' will be shown in the #{time}"
  end

  def take(who)
    case who
    when 'Bank'
      @cashbox.balance *= 0
      puts 'Carried out encashment'
    else
      raise ArgumentError, 'Calling the police'
    end
  end

  def cash
    puts "Earnings: #{@cashbox.balance.format}"
  end

  private

  def buy_ticket(currency)
    @cashbox.balance += Money.from_amount(currency, 'USD')
  end

  def genre_matching(movie, genre)
    movie.genre.include?(genre)
  end

  def render_output(movie)
    puts "Now showing: #{movie.info}"
  end

  def purchase_render(title)
    puts "You've bought ticket to '#{title}'"
  end
end
