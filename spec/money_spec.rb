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
          Money.new(1200, Currency.new('RUB')).to_usd.should == Money.new(12)
        end

        it 'return missing if rate not found' do
          Money.new(1200, Currency.new('Unknown')).to_usd.should == Missing.new
        end

        it 'for a given date' do
          Money.new(1200, Currency.new('RUB')).to_usd(Date.today - 1).should == Money.new(10)
        end
      end
    end

    context 'when invalid money object' do
      it 'returns the object' do
        Error.new.to_usd.should == Error.new
      end
    end
    
    context 'correct load GBP currencies' do
      class GBPTestBank < Extended::Bank
        def usd_rate_for(ccy, date=Date.today)
          return Number.new(0.5)
        end
      end

      before { Extended.bank = GBPTestBank.new }
      after { Extended.bank = Extended::Bank.new }

      context 'when currency is GBP it loads as normal' do
        let(:ccy) { Currency.new('GBP') }
        it 'values is correct' do
          Money.new(1200, ccy).value.should == 1200
        end
        
        it 'USD value is correct' do
          Money.new(1200, ccy).to_usd.should == Money.new(2400)
        end
      end
      
      context 'converts pence to pounds when currency is GBp' do
        let(:ccy) { Currency.new('GBp') }
        it 'value is correct' do
          Money.new(1200, ccy).value.should == 12        
        end

        it 'USD value is correct' do
          Money.new(1200, ccy).to_usd.should == Money.new(24)
        end
      end
    end
  end
end
