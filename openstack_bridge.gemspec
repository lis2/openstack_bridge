# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'openstack_bridge/version'

Gem::Specification.new do |spec|
  spec.name          = "openstack_bridge"
  spec.version       = OpenstackBridge::VERSION
  spec.authors       = ["lis2", "morhekil"]
  spec.email         = ["kotlarek.krzysztof@gmail.com"]
  spec.description   = %q{Openstack ruby integration}
  spec.summary       = %q{Ruby integration with openstack, especially swift}
  spec.homepage      = "https://github.com/lis2/openstack_bridge"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_runtime_dependency "httpi"
end
