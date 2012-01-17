module Extended
  class Number < Object
    def initialize(value)
      @value = ::BigDecimal.new(value_for(value).to_s)
    end
    
    def method_missing(method, *args)
      return @value.send(method, *args) if @value.respond_to?(method)
      super
    end

    def *(multiplier)
      return multiplier if invalid_and_ignore_class?(multiplier)
      return multiplier * self if multiplier.class == Money
      create(value * value_for(multiplier))
    end

    def /(divisor)
      return divisor if invalid_and_ignore_class?(divisor)
      raise 'Can not divide by money' if divisor.class == Money
      create(value / value_for(divisor))
    end

    def +(adder)
      return self if ignore_class?(adder)
      return adder if invalid_class?(adder)
      raise 'Can not add to money' if adder.class == Money
      create(value + value_for(adder))
    end

    def -(subtractor)
      return self if ignore_class?(subtractor)
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
    
    def ==(val)
      super || (val.is_a?(Numeric) && self.value == val)
    end

    def to_yaml
      value.to_s('F')
    end

    private
    def value_for(object)
      object.respond_to?(:value) ? object.value : object
    end

    def create(value)
      Number.new(value)
    end
  end
end
