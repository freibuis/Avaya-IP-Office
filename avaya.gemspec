# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'avaya/version'

Gem::Specification.new do |spec|
  spec.name          = "avaya"
  spec.version       = Avaya::VERSION
  spec.authors       = ["Freibuis"]
  spec.email         = ["freibuis@gmail.com"]
  spec.summary       = %q{A gem to talk to Avaya Ip Office Platform.}
  spec.description   = %q{A gem to talk to Avaya Ip Office Platform.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
