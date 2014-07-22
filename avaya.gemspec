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
  spec.description   = %q{If you are looking to talk to you Avaya Ip Office then this is the gem for you!}
  spec.homepage      = "https://github.com/freibuis/Avaya-IP-Office"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake", "~> 0"
  spec.add_development_dependency "net-tftp", "~> 0.1.0"
end
