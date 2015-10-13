# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'envato/version'

Gem::Specification.new do |spec|
  spec.name          = 'envato'
  spec.version       = Envato::VERSION
  spec.authors       = ['Jacob Bednarz']
  spec.email         = ['jacob.bednarz@envato.com']

  spec.summary       = %q{SDK for interacting with the Envato API.}
  spec.description   = %q{SDK for interacting with the Envato API.}
  spec.homepage      = 'https://build.envato.com'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake',    '~> 10.0'
  spec.add_development_dependency 'rspec',   '~> 3.0',  '>= 3.0.0'
end
