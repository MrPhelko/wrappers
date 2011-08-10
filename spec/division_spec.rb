require 'spec_helper'

module Extended
  describe Number do
    context 'division' do
      it 'can be divided by another number' do
        value = Number.new(12) / Number.new(10)
        value.should == Number.new(1.2)
      end

      it 'can be divided by a ruby number' do
        value = Number.new(13) / 10
        value.should == Number.new(1.3)
      end

      context 'when using error object' do
        it 'returns error when first object is error' do
          value = Error.new / Number.new(10)
          value.should == Error.new
        end

        it 'returns error when second object is error' do
          value = Number.new(10) / Error.new
          value.should == Error.new
        end
      end

      context 'when using missing object' do
        it 'returns missing when first object is missing' do
          value = Missing.new / Number.new(10)
          value.should == Missing.new
        end

        it 'returns missing when second object is missing' do
          value = Number.new(10) / Missing.new
          value.should == Missing.new
        end
      end

      context 'with a Money object' do
        it 'raises an error' do
          expect { Number.new(12) / Money.new(12) }.to raise_error
        end
      end
    end
  end

  describe Money do
    context 'divided' do
      it 'by a number' do
        value = Money.new(12) / Number.new(10)
        value.should == Money.new(1.2)
      end

      it 'by a ruby number' do
        value = Money.new(13) / 10
        value.should == Money.new(1.3)
      end

      it 'raise an error if attempt to divided to money objects' do
        expect { Money.new(12) / Money.new(12) }.to raise_error
      end

      context 'when non-USD money' do
        let(:ccy) { Currency.new('RUB') }
        it 'by a number' do
          value = Money.new(12, ccy) / Number.new(10)
          value.should == Money.new(1.2, ccy)
        end

        it 'by a ruby number' do
          value = Money.new(13, ccy) / 10
          value.should == Money.new(1.3, ccy)
        end
      end
    end
  end
end
