module Extended
  class Bank
    def usd_rate_for(ccy, date=Date.today)
      raise 'You must implement a Bank class to use Currency conversions'
    end

    def ==(bank)
      self.class == bank.class
    end
  end
end
