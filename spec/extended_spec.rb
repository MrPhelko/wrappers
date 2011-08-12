require 'spec_helper'

describe Extended do
  context 'setting up and using a bank' do
    class NewBank < Extended::Bank; end
    class FakeBank; end

    it ' has a default bank object' do
      Extended.bank.should == Extended::Bank.new
    end

    it 'can set a new bank object' do
      Extended.bank = NewBank.new
      Extended.bank.should == NewBank.new
    end

    it 'raises an erro if trying to use a bank that does not inhertite from Extended::Bank' do
      expect { Extended.bank = FakeBank.new }.to raise_error('Bank must inherit from Extended::Bank')
    end
  end
end

describe Extended::Currency do
  it 'will match against a currency string' do
    Extended::Currency.new('USD').should == 'USD'
  end
end
