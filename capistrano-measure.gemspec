# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'capistrano/measure/version'

Gem::Specification.new do |spec|
  spec.name          = "capistrano-measure"
  spec.version       = Capistrano::Measure::VERSION
  spec.authors       = ["Artūrs Mekšs"]
  spec.email         = ["arturs.mekss@tieto.com"]
  spec.summary       = "Capistrano deployment speed measure tool"
  spec.description   = "In order to improve something you have to measure it! This helps you measure performance of your Capistrano deployments by appending performance reports after each Capistrano execution"
  spec.homepage      = "https://github.com/AMekss/capistrano-measure.git"
  spec.license       = "MIT"
  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "capistrano", ">= 2", "< 4"
  spec.add_dependency "colored", "~> 1.2"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency 'timecop', '~> 0.7'

end
