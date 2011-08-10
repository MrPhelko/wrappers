require 'bigdecimal'

module Extended
  module DefaultConfiguration
    def ==(object)
      self.class == object.class
    end

    def *(val)
      self
    end

    def to_s
      '-'
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
      raise 'Can not multiply 2 numbers' if multiplier.class == Money
      super
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
