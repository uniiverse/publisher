# -*- encoding: utf-8 -*-

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'publisher/version'

Gem::Specification.new do |spec|
  spec.name          = 'publisher'
  spec.version       = Publisher::VERSION
  spec.authors       = ['Ahmed El.Hussaini']
  spec.email         = ['aelhussaini@gmail.com']

  spec.summary       = "publisher-#{Publisher::VERSION}"
  spec.description   = %q{A convenient Pubsub events publisher}
  spec.homepage      = 'https://github.com/universe/publisher'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.files           += ['LICENSE.md']
  spec.extra_rdoc_files = ['README.md']
  spec.rdoc_options     = ['--charset=UTF-8']
  spec.files            = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.require_paths = ['lib']

  spec.add_dependency 'activesupport', '>= 4.2.0'
  spec.add_dependency 'google-cloud-pubsub', '>= 0.27.2'

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'pry', '~> 0.11.3'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rspec-mocks'
  spec.add_development_dependency 'rubocop', '~> 0.59.2'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'simplecov-console'
  spec.add_development_dependency 'yard', '~> 0.9.16'
  spec.add_development_dependency 'rspec_junit_formatter', '~> 0.4.1'
end
