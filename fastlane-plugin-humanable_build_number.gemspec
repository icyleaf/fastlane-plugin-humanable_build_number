# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fastlane/plugin/humanable_build_number/version'

Gem::Specification.new do |spec|
  spec.name          = 'fastlane-plugin-humanable_build_number'
  spec.version       = Fastlane::HumanableBuildNumber::VERSION
  spec.author        = %q{icyleaf}
  spec.email         = %q{icyleaf.cn@gmail.com}

  spec.summary       = %q{Automatic generate app build number unque and human readable friendly, like yymmHHMM. both support iOS and Android.}
  spec.homepage      = "https://github.com/icyleaf/fastlane-plugin-humanable_build_number"
  spec.license       = "MIT"

  spec.files         = Dir["lib/**/*"] + %w(README.md LICENSE)
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'fastlane', '>= 1.111.0'
end
