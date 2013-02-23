# -*- encoding: utf-8 -*-
require File.expand_path('../lib/bloat_check/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["ronen barzel"]
  gem.email         = ["ronen@barzel.org"]
  gem.description   = %q{Another ruby/rails bloat and memory leak debugging tool.}
  gem.summary       = %q{Another ruby/rails bloat and memory leak debugging tool.}
  gem.homepage      = "http://github.com/ronen/bloat_check"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "bloat_check"
  gem.require_paths = ["lib"]
  gem.version       = BloatCheck::VERSION

  gem.add_dependency 'key_struct'
  gem.add_dependency 'its-it'

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'simplecov'
  gem.add_development_dependency 'simplecov-gem-adapter'
end
