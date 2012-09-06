# -*- encoding: utf-8 -*-
require File.expand_path('../lib/event_tracker/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Jay Wengrow"]
  gem.email         = ["jaywngrw@gmail.com"]
  gem.description   = %q{This is a simple event tracker using Ruby/Redis}
  gem.summary       = %q{Easily track custom events triggered by users of your Rails app and view their statistics on a dashboard.}
  gem.homepage      = "http://github.com/jaywengrow/event_tracker"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "event_tracker"
  gem.require_paths = ["lib"]
  gem.version       = EventTracker::VERSION

  gem.add_development_dependency "rspec"
end
