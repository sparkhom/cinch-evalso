# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "cinch-evalso"
  spec.version       = "0.1.3"
  spec.authors       = ["Serguey Parkhomovsky"]
  spec.email         = ["xindigo@gmail.com"]
  spec.homepage      = "https://github.com/sparkhom/cinch-evalso"
  spec.description   = %q{Cinch plugin to evaluate code with different languages using the eval.so API}
  spec.summary       = %q{Cinch plugin to query the eval.so API}
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "cinch"
  spec.add_dependency "httparty"
  spec.add_dependency "gist"
end
