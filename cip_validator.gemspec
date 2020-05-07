
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "cip_validator/version"

Gem::Specification.new do |spec|
  spec.name          = "cip_validator"
  spec.version       = CipValidator::VERSION
  spec.authors       = ["Makoto", "Raisty"]
  spec.email         = ["rastislav@coreblockchain.cc"]

  spec.summary       = "Small library to check if CIP doc has valid front matter"
  spec.homepage      = "https://github.com/raisty/cip_validator"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_dependency "front_matter_parser", "~> 0.1.1"
  spec.add_dependency "activemodel"
end
