require 'spec_helper'

module Extended
  describe Money do
    context 'converting to USD' do
      context 'with default bank' do
        it 'raise an error' do
          expect { Money.new(12).to_usd }.to raise_error
        end
      end

      context 'with a bank set' do
        class TestBank < Extended::Bank
          def usd_rate_for(ccy, date=Date.today)
            return Number.new(1) if ccy == 'USD'
            return Number.new(100) if ccy == 'RUB' and date == Date.today
            return Number.new(120) if ccy == 'RUB'
            Missing.new
          end
        end
        before { Extended.bank = TestBank.new }
        after { Extended.bank = Extended::Bank.new }

        it 'return the value if already in USD' do
          Money.new(12).to_usd.should == Money.new(12)
        end

        it 'return the converted value if non-USD' do
          Money.new(1200, 'RUB').to_usd.should == Money.new(12)
        end

        it 'return missing if rate not found' do
          Money.new(1200, 'Unknown').to_usd.should == Missing.new
        end

        it 'for a given date' do
          Money.new(1200, 'RUB').to_usd(Date.today - 1).should == Money.new(10)
        end
      end
    end

    context 'when invalid money object' do
      it 'returns the object' do
        Error.new.to_usd.should == Error.new
      end
    end
  end
end
