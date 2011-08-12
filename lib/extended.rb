require 'bigdecimal'
require 'formatter'
require 'bank'

module Extended
  @@bank = Bank.new

  def self.bank
    @@bank
  end

  def self.bank=(bank)
    raise 'Bank must inherit from Extended::Bank' unless bank.class.ancestors.include?(Extended::Bank)
    @@bank = bank
  end

  module DefaultConfiguration
    def ==(object)
      self.class == object.class
    end

    def *(val)
      self
    end

    def /(val)
      self
    end

    def +(val)
      self
    end

    def -(val)
      self
    end

    def to_s(*args)
      '-'
    end

    def to_usd(*args)
      self
    end

    def sign_of_value
      nil
    end
  end

  class Error; include Extended::DefaultConfiguration; end
  class Missing; include Extended::DefaultConfiguration; end
  class Blank; include Extended::DefaultConfiguration; end

  class Object
    attr_reader :value
    def initialize(value)
      @value = value
    end

    def ==(object)
      self.class == object.class &&
        value == object.value
    end

    def to_s
      @value
    end

    private
    def invalid_class?(object)
      [Error, Missing, Blank].include?(object.class)
    end
  end

  class String < Object
  end

  class Number < Object
    def initialize(value)
      @value = ::BigDecimal.new(value.to_s)
    end

    def *(multiplier)
      return multiplier if invalid_class?(multiplier)
      return multiplier * self if multiplier.class == Money
      create(value * value_for(multiplier))
    end

    def /(divisor)
      return divisor if invalid_class?(divisor)
      raise 'Can not divide by money' if divisor.class == Money
      create(value / value_for(divisor))
    end

    def +(adder)
      return adder if invalid_class?(adder)
      raise 'Can not add to money' if adder.class == Money
      create(value + value_for(adder))
    end

    def -(subtractor)
      return subtractor if invalid_class?(subtractor)
      raise 'Can not add to money' if subtractor.class == Money
      create(value - value_for(subtractor))
    end

    def sign_of_value
      value >= 0 ? 'positive' : 'negative'
    end

    def to_s(options={})
      return PercentageFormatter.new(value, options).format if options[:as] == :percentage
      NumberFormatter.new(value, options).format
    end

    private
    def value_for(object)
      object.respond_to?(:value) ? object.value : object
    end

    def create(value)
      Number.new(value)
    end
  end

  class Money < Number
    attr_reader :currency
    def initialize(value, currency=nil)
      @currency = (currency || Extended::Currency.new('USD'))
      super(value)
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
      usd_value = (number / Extended.bank.usd_rate_for(currency, date))
      return usd_value if invalid_class?(usd_value)
      Money.new(usd_value)
    end

    def ==(money)
      super && self.currency == money.currency
    end

    private
    def number
      Number.new(value)
    end

    def create(value)
      Money.new(value, currency)
    end
  end

  class Currency < Object
    def ==(currency)
      super || value == currency
    end
  end

  class DateTime < Object
    def initialize(value)
      @value = ::DateTime.parse(value)
    end

    def to_s
      @value.strftime('%d %b %Y %H:%M')
    end
  end
end
