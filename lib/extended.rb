require 'bigdecimal'
require 'formatter'
require 'active_support'
require 'bank'

begin
  require 'active_support/all'
rescue LoadError
  # activesupport/all was a later addition
end

module Extended
  @@bank = Bank.new

  def self.bank
    @@bank
  end

  def self.bank=(bank)
    raise 'Bank must inherit from Extended::Bank' unless bank.class.ancestors.include?(Extended::Bank)
    @@bank = bank
  end

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

    def value
      nil
    end

    def to_usd(*args)
      self
    end

    def sign_of_value
      nil
    end
  end

  class Error; include Extended::DefaultConfiguration; end
  class Missing; include Extended::DefaultConfiguration; end
  class Blank; include Extended::DefaultConfiguration; end
end

require 'extended/object'
require 'extended/string'
require 'extended/number'
require 'extended/currency'
require 'extended/money'
require 'extended/datetime'

