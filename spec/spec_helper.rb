$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rspec'
require 'extended'
require 'ruby-debug'
RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
end
