require 'spec_helper'

module Extended
  describe 'Number formatting' do
    context 'default format' do
      it 'integer number 0 to 999' do
        Number.new(1).to_s.should == '1'
        Number.new(100).to_s.should == '100'
        Number.new(999).to_s.should == '999'
      end

      it 'integer number -1 to -999' do
        Number.new(-1).to_s.should == '-1'
        Number.new(-100).to_s.should == '-100'
        Number.new(-999).to_s.should == '-999'
      end

      it 'with rounding' do
        Number.new(1.1).to_s.should == '1'
        Number.new(1.5).to_s.should == '2'
        Number.new(1.8).to_s.should == '2'
      end

      it 'with rounding for negatives' do
        Number.new(-1.1).to_s.should == '-1'
        Number.new(-1.5).to_s.should == '-2'
        Number.new(-1.8).to_s.should == '-2'
      end

      it 'numbers greater than 999' do
        Number.new(1000).to_s.should == '1,000'
        Number.new(1000000).to_s.should == '1,000,000'
      end
    end

    context 'with decimal places' do
      it 'when integer part is 0' do
        Number.new(0.1).to_s(:decimals => 1).should == '0.1'
        Number.new(0.01).to_s(:decimals => 2).should == '0.01'
      end
    end
  end

  describe 'Money formatting' do
    context 'default format' do
      it 'integer number 0 to 999' do
        Money.new(1).to_s.should == '1.00 USD'
        Money.new(100).to_s.should == '100.00 USD'
        Money.new(999).to_s.should == '999.00 USD'
      end

      it 'integer number -1 to -999' do
        Money.new(-1).to_s.should == '(1.00 USD)'
        Money.new(-100).to_s.should == '(100.00 USD)'
        Money.new(-999).to_s.should == '(999.00 USD)'
      end
    end

    context 'ignoring ccy' do
      it 'does not include the currency symbol' do
        Money.new(-1).to_s({:hide_currency => true}).should == '(1.00)'
        Money.new(1).to_s({:hide_currency => true}).should == '1.00'
      end
    end
  end
end