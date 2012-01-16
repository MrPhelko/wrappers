module Extended
  class Blank
    include Extended::DefaultConfiguration
    
    def +(val)
      return self if [Blank, Error, Missing].include?(val.class)
      val
    end

    def -(val)
      return self if [Blank, Error, Missing].include?(val.class)
      val * -1
    end
  end
end