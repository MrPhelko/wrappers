require 'spec_helper'

module Extended
  describe Number do
    context 'multiplication' do
      it 'can be multiplied by another number' do
        value = Number.new(10) * Number.new(12)
        value.should == Number.new(120)
      end

      it 'can be multiplied by a ruby number' do
        value = Number.new(10) * 13
        value.should == Number.new(130)
      end

      context 'when using error object' do
        it 'retruns error when first object is error' do
          value = Error.new * Number.new(10)
          value.should == Error.new
        end

        it 'retruns error when second object is error' do
          value = Number.new(10) * Error.new
          value.should == Error.new
        end
      end

      context 'when using missing object' do
        it 'retruns missing when first object is missing' do
          value = Missing.new * Number.new(10)
          value.should == Missing.new
        end

        it 'retruns missing when second object is missing' do
          value = Number.new(10) * Missing.new
          value.should == Missing.new
        end
      end

      context 'with a Money object' do
        it 'raises an error' do
          value = Number.new(12) * Money.new(12)
          value.should == Money.new(144)
        end
      end
    end
  end

  describe Money do
    context 'multiplication' do
      it 'by a number' do
        value = Money.new(12) * Number.new(10)
        value.should == Money.new(120)
      end

      it 'by a ruby number' do
        value = Money.new(13) * 10
        value.should == Money.new(130)
      end

      it 'raise an error if attempt to multpile to money objects' do
        expect { Money.new(12) * Money.new(12) }.to raise_error
      end

      context 'when non-USD money' do
        let(:ccy) { Currency.new('RUB') }
        it 'by a number' do
          value = Money.new(12, ccy) * Number.new(10)
          value.should == Money.new(120, ccy)
        end

        it 'by a ruby number' do
          value = Money.new(13, ccy) * 10
          value.should == Money.new(130, ccy)
        end
      end
    end
  end
end
