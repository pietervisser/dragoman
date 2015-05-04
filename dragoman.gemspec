# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dragoman/version'

Gem::Specification.new do |spec|
  spec.name          = "dragoman"
  spec.version       = Dragoman::VERSION
  spec.authors       = ["Pieter Visser"]
  spec.email         = ["pieter@pietervisser.nl"]
  spec.summary       = %q{TODO: Write a short summary. Required.}
  spec.description   = %q{TODO: Write a longer description. Optional.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency("activesupport", ">= 3.1.0")
  spec.add_development_dependency("rails", ">= 4.1.0")
  spec.add_development_dependency("rspec-rails")
  spec.add_development_dependency("guard-rspec")
end
