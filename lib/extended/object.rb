module Extended
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
      [Error, Missing].include?(object.class)
    end
    
    def ignore_class?(object)
      [Blank].include?(object.class)
    end
  end
end
