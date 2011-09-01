# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "wrappers"
  gem.homepage = "http://github.com/dwhenry/wrappers"
  gem.license = "MIT"
  gem.summary = %Q{Helper gem used to remove primitive obsession}
  gem.description = %Q{Provides simple Money, Number and Date classes to handle errors from the web services}
  gem.email = "dw_henry@yahoo.com.au"
  gem.authors = ["David Henry and Alberto Peña"]
  # dependencies defined in Gemfile
end

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end
