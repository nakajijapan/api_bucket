# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'api_bucket/version'

Gem::Specification.new do |gem|
  gem.name          = "api_bucket"
  gem.version       = ApiBucket::VERSION
  gem.authors       = ["nakajijapan"]
  gem.email         = ["pp.kupepo.gattyanmo@gmail.com"]
  gem.description   = %q{We can use sevral APIs with common interface.}
  gem.summary       = %q{We can use sevral APIs with common interface}
  gem.homepage      = "https://github.com/nakajijapan/api_bucket"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "nokogiri"
  gem.add_dependency "ruby-hmac"
  gem.add_development_dependency('rspec', ['~> 2.8.0'])
end
