Gem::Specification.new do |s|
  s.name = "wrappers"
  s.version = "0.3.9"

  s.authors = ["David Henry", "Alberto Pe\u{f1}a"]
  s.date = "2013-08-13"
  s.summary = "Helper gem used to remove primitive obsession"
  s.description = "Provides simple Money, Number and Date classes to handle errors from the web services"
  s.email = "dw_henry@yahoo.com.au"
  s.license     = 'Copyright (c) 2011 Lyagushka Limited. All rights reserved.'
  s.homepage = 'https://github.com/ProsperityCapital/webservice_interface'

  s.platform                  = Gem::Platform::RUBY
  s.required_rubygems_version = '>= 1.3.7'
  s.required_ruby_version     = '>= 1.8.7'

  s.files = Dir['lib/**/*.rb',
                'LICENSE.txt',
                'README',
                'wrappers.gemspec']
  s.test_files = Dir['spec/**/*.rb']
  s.require_path = 'lib'

  s.add_runtime_dependency('activesupport', '~> 2.3.15')
  s.add_development_dependency('rspec', '~> 2.14.1')
end
