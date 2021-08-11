# frozen_string_literal: true

require 'money'

Money.locale_backend = nil
Money.rounding_mode = BigDecimal::ROUND_HALF_EVEN

module Cashbox
  class TheatreCash
    def self.balance
      @amount = Money.from_amount(0, 'USD')
    end
  end

  class NetflixCash
    def self.balance
      @amount = Money.from_amount(0, 'USD')
    end
  end
end
