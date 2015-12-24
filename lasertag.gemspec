# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'lasertag/version'

Gem::Specification.new do |spec|
  spec.name          = "lasertag"
  spec.version       = Lasertag::VERSION
  spec.authors       = ["cesarferreira"]
  spec.email         = ["cesar.manuel.ferreira@gmail.com"]

  spec.summary       = %q{Tag your android version in you CVS with ease.}
  spec.description   = %q{Tag your android version in you CVS with ease.}
  spec.homepage      = "https://github.com/cesarferreira/lasertag"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
