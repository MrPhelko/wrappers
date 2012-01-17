# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "wrappers"
  s.version = "0.3.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["David Henry and Alberto Pe\303\261a"]
  s.date = "2012-01-17"
  s.description = "Provides simple Money, Number and Date classes to handle errors from the web services"
  s.email = "dw_henry@yahoo.com.au"
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    ".rvmrc",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "lib/bank.rb",
    "lib/extended.rb",
    "lib/extended/blank.rb",
    "lib/extended/currency.rb",
    "lib/extended/datetime.rb",
    "lib/extended/money.rb",
    "lib/extended/number.rb",
    "lib/extended/object.rb",
    "lib/extended/string.rb",
    "lib/formatter.rb",
    "spec/addition_spec.rb",
    "spec/bank_spec.rb",
    "spec/currency_spec.rb",
    "spec/datetime_spec.rb",
    "spec/division_spec.rb",
    "spec/equality_spec.rb",
    "spec/extended_spec.rb",
    "spec/formating_spec.rb",
    "spec/missing_spec.rb",
    "spec/money_spec.rb",
    "spec/multiplication_spec.rb",
    "spec/spec_helper.rb",
    "spec/subtraction_spec.rb",
    "spec/summing_numbers_and_blanks_spec.rb",
    "spec/to_yaml_spec.rb",
    "wrappers.gemspec"
  ]
  s.homepage = "http://github.com/dwhenry/wrappers"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.10"
  s.summary = "Helper gem used to remove primitive obsession"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activesupport>, [">= 0"])
      s.add_development_dependency(%q<rspec>, ["~> 2.3.0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.6.2"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
      s.add_development_dependency(%q<ruby-debug>, [">= 0"])
      s.add_development_dependency(%q<i18n>, [">= 0"])
    else
      s.add_dependency(%q<activesupport>, [">= 0"])
      s.add_dependency(%q<rspec>, ["~> 2.3.0"])
      s.add_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.6.2"])
      s.add_dependency(%q<rcov>, [">= 0"])
      s.add_dependency(%q<ruby-debug>, [">= 0"])
      s.add_dependency(%q<i18n>, [">= 0"])
    end
  else
    s.add_dependency(%q<activesupport>, [">= 0"])
    s.add_dependency(%q<rspec>, ["~> 2.3.0"])
    s.add_dependency(%q<bundler>, ["~> 1.0.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.6.2"])
    s.add_dependency(%q<rcov>, [">= 0"])
    s.add_dependency(%q<ruby-debug>, [">= 0"])
    s.add_dependency(%q<i18n>, [">= 0"])
  end
end

