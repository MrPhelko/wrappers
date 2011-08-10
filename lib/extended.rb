require 'bigdecimal'
require 'formatter'

module Extended
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
  end

  class String < Object
  end

  class Number < Object
    def initialize(value)
      @value = ::BigDecimal.new(value.to_s)
    end

    def *(multiplier)
      return multiplier if [Error, Missing, Blank].include?(multiplier.class)
      return multiplier * self if multiplier.class == Money

      multiply_by = multiplier.respond_to?(:value) ? multiplier.value : multiplier
      create(value * multiply_by)
    end

    def /(divisor)
      return divisor if [Error, Missing, Blank].include?(divisor.class)
      raise 'Can not divide by money' if divisor.class == Money

      divide_by = divisor.respond_to?(:value) ? divisor.value : divisor
      create(value / divide_by)
    end

    def +(adder)
      return adder if [Error, Missing, Blank].include?(adder.class)
      raise 'Can not add to money' if adder.class == Money

      add_by = adder.respond_to?(:value) ? adder.value : adder
      create(value + add_by)
    end

    def -(subtractor)
      return subtractor if [Error, Missing, Blank].include?(subtractor.class)
      raise 'Can not add to money' if subtractor.class == Money

      subtract_by = subtractor.respond_to?(:value) ? subtractor.value : subtractor
      create(value - subtract_by)
    end

    def sign_of_value
      value >= 0 ? 'positive' : 'negative'
    end

    def to_s(options={})
      return PercentageFormatter.new(value, options).format if options[:as] == :percentage
      NumberFormatter.new(value, options).format
    end

    private

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
      return adder if [Error, Missing, Blank].include?(adder.class)
      raise 'Can only add two moneys' unless adder.class == Money
      raise 'Currency must match to add' unless currency == adder.currency
      create(value + adder.value)
    end

    def -(substractor)
      return substractor if [Error, Missing, Blank].include?(substractor.class)
      raise 'Can only subtract two moneys' unless substractor.class == Money
      raise 'Currency must match to subtract' unless currency == substractor.currency
      create(value - substractor.value)
    end

    def to_s(options={})
      MoneyFormatter.new(value, currency, options).format
    end

    def ==(money)
      super && self.currency == money.currency
    end

    private
    def create(value)
      Money.new(value, currency)
    end
  end

  class Currency < Object
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
