lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'envato/version'

Gem::Specification.new do |spec|
  spec.name          = 'envato-sdk'
  spec.version       = Envato::VERSION
  spec.authors       = ['Jacob Bednarz']
  spec.email         = ['jacob.bednarz@envato.com']

  spec.summary       = %q{SDK for interacting with the Envato API.}
  spec.description   = %q{SDK for interacting with the Envato API.}
  spec.homepage      = 'https://build.envato.com'
  spec.license       = 'MIT'

  spec.files         = Dir.glob('lib/**/*') + %w(LICENSE README.md)
  spec.require_paths = ['lib']
  spec.required_ruby_version = '~> 2.0'

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake',    '~> 10.0'
  spec.add_development_dependency 'rspec',   '~> 3.0',  '>= 3.0.0'
  spec.add_development_dependency 'vcr',     '~> 2.7',  '>= 2.7.0'
  spec.add_development_dependency 'webmock', '~> 1.15'

  spec.add_runtime_dependency 'faraday',     '~> 0.8',  '>= 0.8.9'
  spec.add_runtime_dependency 'multi_json',  '~> 1.8',  '>= 1.8.2'
end
