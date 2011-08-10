module Extended
  class Formatter
    def initialize(value, options = {})
      @value = value.abs
      @positive = value >= 0
      @decimal_places = options[:decimals] || 0
    end

    private
    def format_number
      return format_integer if decimal_places == 0
      "#{format_integer}.#{format_decimals}"
    end

    def format_integer
      return '0' unless has_integer_part?
      integer_with_separators
    end

    def integer_with_separators
      integer = integer_part
      while integer.gsub!(/(\d)(\d{3})(,|$)/, '\1,\2\3'); end
      integer
    end

    def has_integer_part?
      value_as_string.size > decimal_places
    end

    def integer_part
      value_as_string[0..-(decimal_places + 1)]
    end

    def format_decimals
      number = '0' * decimal_places + value_as_string
      number[-decimal_places..-1]
    end

    def value_as_string
      @value_as_string ||= round.to_s('F').split('.').first
    end

    def round
      (@value * 10**decimal_places).round
    end

    def decimal_places
      @decimal_places
    end
  end

  class NumberFormatter < Formatter
    def format
      return format_number if @positive
      "-#{format_number}"
    end
  end

  class PercentageFormatter < NumberFormatter
    def initialize(value, options)
      super
      @value = value * 100
    end

    def format
      "#{super} %"
    end
  end

  class MoneyFormatter < Formatter
    def initialize(value, currency, options={})
      @currency = currency
      @hide_currency = options[:hide_currency] || false
      super(value, {:decimals => 2}.merge(options))
    end

    def format
      return "#{format_currency}" if @positive
      return "(#{format_currency})"
    end

    private
    def format_currency
      return format_number if @hide_currency
      "#{format_number} #{currency.to_s}" 
    end

    def currency
      @currency
    end
  end
end
