require 'spec_helper'

describe Extended::Bank do
  it 'requires implementation in a sub class' do
    expect { subject.usd_rate_for('RUB') }.to raise_error('You must implement a Bank class to use Currency conversions')
  end
  
  context 'normalization of currncy values' do
    context 'for British Pounds/Pence' do
      it 'divides by 100 when GBp' do
        subject.normalize_value('100', Extended::Currency.new('GBp')).should == Extended::Number.new(1)
        subject.normalize_value(100, Extended::Currency.new('GBp')).should == Extended::Number.new(1)
      end
      
      it 'returns the value when GBP' do
        subject.normalize_value('100', Extended::Currency.new('GBP')).should == Extended::Number.new(100)
        subject.normalize_value(100, Extended::Currency.new('GBP')).should == Extended::Number.new(100)
      end
    end
    
    context 'for other currencies' do
      it 'retruns the input value' do
        subject.normalize_value('100', Extended::Currency.new('USD')).should == Extended::Number.new(100)
        subject.normalize_value(100, Extended::Currency.new('USD')).should == Extended::Number.new(100)
      end
    end
  end
end
