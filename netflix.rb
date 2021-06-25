# frozen_string_literal: true

class Netflix < MovieCollection
  attr_accessor :wallet

  require_relative 'movie_collection'

  def initialize
    super
    @wallet = 0
  end

  def pay(currency)
    @wallet + currency
  end

  def show
  end
end
