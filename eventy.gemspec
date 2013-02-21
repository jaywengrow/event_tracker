# -*- encoding: utf-8 -*-
require File.expand_path('../lib/eventy/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Jay Wengrow"]
  gem.email         = ["jaywngrw@gmail.com"]
  gem.description   = %q{Simple event tracker for Rails using Redis}
  gem.summary       = %q{Easily track custom events triggered by users of your Rails app and view their statistics on a dashboard.}
  gem.homepage      = "https://github.com/jaywengrow/eventy"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "eventy"
  gem.require_paths = ["lib"]
  gem.version       = Eventy::VERSION

  gem.add_dependency 'redis',           '>= 2.1'
  gem.add_dependency 'redis-namespace', '>= 1.0.3'
  gem.add_dependency 'sinatra',         '>= 1.2.6'

  gem.add_development_dependency "rspec"
  gem.add_development_dependency 'rack-test',   '~> 0.6'
end
