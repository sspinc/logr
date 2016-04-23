# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'logr/version'

Gem::Specification.new do |spec|
  spec.name          = "logr"
  spec.version       = Logr::VERSION
  spec.authors       = ["Peter Marton", "Tamas Michelberger"]
  spec.email         = ["martonpe@secretsaucepartners.com", "tomi@secretsaucepartners.com"]

  spec.summary       = "Structured logging with events and metrics"
  spec.description   = "Structured logging with events and metrics"
  spec.homepage      = "https://github.com/sspinc/logr"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.bindir        = "exe"
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "byebug"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "timecop", "~> 0.8"
end
