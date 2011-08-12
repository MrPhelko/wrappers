require 'spec_helper'

describe Extended::Bank do
  it 'requires implementation in a sub class' do
    expect { subject.usd_rate_for('RUB') }.to raise_error('You must implement a Bank class to use Currency conversions')
  end
end
