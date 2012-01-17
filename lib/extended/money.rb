module Extended
  class Money < Number
    attr_reader :currency
    def initialize(value, currency=nil)
      @currency = (currency || Extended::Currency.new('USD'))
      super(Extended.bank.normalize_value(value, @currency))
    end

    def *(multiplier)
      raise 'Can not multiply 2 moneys' if multiplier.class == Money
      super
    end

    def /(divisor)
      return super unless divisor.class == Money
      raise 'Can not divide moneys with different currency' unless currency == divisor.currency
      Number.new(value / divisor.value)
    end

    def +(adder)
      return adder if invalid_class?(adder)
      raise 'Can only add two moneys' unless adder.class == Money
      raise 'Currency must match to add' unless currency == adder.currency
      create(value + adder.value)
    end

    def -(substractor)
      return substractor if invalid_class?(substractor)
      raise 'Can only subtract two moneys' unless substractor.class == Money
      raise 'Currency must match to subtract' unless currency == substractor.currency
      create(value - substractor.value)
    end

    def to_s(options={})
      MoneyFormatter.new(value, currency, options).format
    end

    def to_usd(date=Date.today)
      usd_value = (number / Extended.bank.usd_rate_for(currency.to_s, date))
      return usd_value if invalid_class?(usd_value)
      Money.new(usd_value)
    end

    def ==(money)
      super && self.class == money.class && self.currency == money.currency
    end

    private
    def number
      Number.new(value)
    end

    def create(value)
      Money.new(value, currency)
    end
  end

end
