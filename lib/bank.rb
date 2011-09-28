module Extended
  class Bank
    NORMALIZING_RATIO = {'GBp' => BigDecimal.new('0.01')}
    def usd_rate_for(ccy, date=Date.today)
      raise 'You must implement a Bank class to use Currency conversions'
    end

    def ==(bank)
      self.class == bank.class
    end
    
    def normalize_value(value, currency)
      return value unless NORMALIZING_RATIO.keys.include?(currency.value)
      value * NORMALIZING_RATIO[currency.value]
    end
  end
end
