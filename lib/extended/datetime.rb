module Extended
  class DateTime < Object
    def initialize(value)
      @value = ::DateTime.parse(value)
    end

    def to_s
      @value.strftime('%d %b %Y %H:%M')
    end

    # we expect it to function similar to a datetime
    delegate :to_time, :to_date, :to_datetime, :to_f, :to_i, :to => :value
  end
end
