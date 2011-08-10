require 'spec_helper'

module Extended
  describe Number do
    context 'subtraction' do
      it 'can be subtracted by another number' do
        value = Number.new(12) - Number.new(10)
        value.should == Number.new(2)
      end

      it 'can be subtracted by a ruby number' do
        value = Number.new(10) - 13
        value.should == Number.new(-3)
      end

      context 'when using error object' do
        it 'retruns error when first object is error' do
          value = Error.new - Number.new(10)
          value.should == Error.new
        end

        it 'retruns error when second object is error' do
          value = Number.new(10) - Error.new
          value.should == Error.new
        end
      end

      context 'when using missing object' do
        it 'retruns missing when first object is missing' do
          value = Missing.new - Number.new(10)
          value.should == Missing.new
        end

        it 'retruns missing when second object is missing' do
          value = Number.new(10) - Missing.new
          value.should == Missing.new
        end
      end

      context 'with a Money object' do
        it 'raises an error' do
          expect { Number.new(12) - Money.new(12) }.to raise_error
        end
      end
    end
  end

  describe Money do
    context 'subtraction' do
      it 'by a number' do
        expect { Money.new(12) - Number.new(10) }.to raise_error
      end

      it 'by a ruby number' do
        expect { Money.new(12) - 10 }.to raise_error
      end

      it 'raise an error if attempt to subtracted to money objects' do
        value = Money.new(12) - Money.new(12)
        value.should == Money.new(0)
      end

      context 'when non-USD money' do
        let(:ccy) { Currency.new('RUB') }
        it 'by a number' do
          expect { Money.new(12, ccy) - Number.new(10) }.to raise_error
        end

        it 'by a ruby number' do
          expect { Money.new(13, ccy) - 10 }.to raise_error
        end

        it 'when matching currencies' do
          value = Money.new(10, ccy) - Money.new(12, ccy)
          value.should == Money.new(-2, ccy)
        end

        it 'when non matching currencies' do
          expect { Money.new(10, ccy) - Money.new(12) }.to raise_error
        end
      end
    end
  end
end
