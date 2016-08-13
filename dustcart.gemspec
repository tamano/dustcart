# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dustcart/version'

Gem::Specification.new do |spec|
  spec.name          = "dustcart"
  spec.version       = Dustcart::VERSION
  spec.authors       = ["Yuya TAMANO"]
  spec.email         = ["everfree.main@gmail.com"]

  spec.summary       = %q{S3 integrated backup tool.}
  spec.description   = %q{CLI tool to send files/db_dump to S3.}
  spec.homepage      = "https://github.com/tamano/dustcart"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency 'rubocop'

  spec.add_dependency "thor"
end
