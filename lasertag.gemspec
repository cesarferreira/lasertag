# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'lasertag/version'

#rake build    # Build lasertag-0.0.1.gem into the pkg directory
#rake install  # Build and install lasertag-0.0.1.gem into system gems
#rake release  # Create tag v0.0.1 and build and push lasertag-0.0.1.gem t...
#rake spec     # Run RSpec code examples

Gem::Specification.new do |spec|
  spec.name          = "lasertag"
  spec.version       = Lasertag::VERSION
  spec.authors       = ["cesarferreira"]
  spec.email         = ["cesar.manuel.ferreira@gmail.com"]

  spec.summary       = %q{Automatically map android app version to git tags}
  spec.description   = %q{Automatically map android app version to git tags}
  spec.homepage      = "https://github.com/cesarferreira/lasertag"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 2.0.0'

  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'pry-byebug', '~> 3.2'
  spec.add_development_dependency 'rspec'

  spec.add_dependency 'bundler', '~> 1.7'
  spec.add_dependency 'colorize',  '~> 0.7'
  spec.add_dependency 'oga',  '~> 1.3.1'
  spec.add_dependency 'hirb'
  spec.add_dependency 'git', '~> 1.2'

end
