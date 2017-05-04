# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'lono_cfn/version'

Gem::Specification.new do |spec|
  spec.name          = "lono-cfn"
  spec.version       = LonoCfn::VERSION
  spec.authors       = ["Tung Nguyen"]
  spec.email         = ["tongueroo@gmail.com"]
  spec.description   = %q{Wrapper cfn tool to quickly create CloudFormation stacks from lono templates and params files}
  spec.summary       = %q{Wrapper cfn tool to quickly create CloudFormation stacks from lono templates and params files}
  spec.homepage      = "https://github.com/tongueroo/lono-cfn"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "thor"
  spec.add_dependency "hashie"
  spec.add_dependency "colorize"
  spec.add_dependency "lono"
  spec.add_dependency "aws-sdk"
  spec.add_dependency "plissken" # dependency for vendor/lono-params

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-bundler"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "byebug"
end
