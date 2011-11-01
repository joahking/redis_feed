# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "redis_feed/version"

Gem::Specification.new do |s|
  s.name        = "redis_feed"
  s.version     = RedisFeed::VERSION
  s.authors     = ["Joaquin Rivera Padron"]
  s.email       = ["joahking@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{A minimal feed using redis}
  s.description = %q{A minimal feed using redis}

  s.rubyforge_project = "redis_feed"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  s.add_runtime_dependency "redis"
  s.add_runtime_dependency "SystemTimer"
end
