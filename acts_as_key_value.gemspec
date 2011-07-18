# -*- encoding: utf-8 -*-
require File.expand_path('../lib/acts_as_key_value/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Maciej Gajewski"]
  gem.email         = ["gajewski.mm@gmail.com"]
  gem.description   = %q{Acts_as_key_value lets you turn your model into key/value storage}
  gem.summary       = %q{Acts_as_key_value lets you turn your model into key/value storage. You get some convenient setters and getters like [], []=, get, set etc.}
  gem.homepage      = ''

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "acts_as_key_value"
  gem.require_paths = ['lib']
  gem.version       = ActsAsKeyValue::VERSION

  gem.add_development_dependency "rspec"
  gem.add_dependency "rails", "~>3.0"
end
