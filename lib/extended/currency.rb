module Extended
  class Currency < Object
    def ==(currency)
      super || value == currency
    end

    def to_s
      @value.upcase
    end
  end

end
