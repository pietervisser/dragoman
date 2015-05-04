# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dragoman/version'

Gem::Specification.new do |spec|
  spec.name          = "dragoman"
  spec.version       = Dragoman::VERSION
  spec.authors       = ["Pieter Visser", "Robert Jan de Gelder"]
  spec.email         = ["info@greenonline.nl"]
  spec.summary       = %q{Simple Rails Routes Translator}
  spec.homepage      = "http://github.com/pietervisser/dragoman"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency("rspec-rails")
  spec.add_development_dependency("guard-rspec")
end
