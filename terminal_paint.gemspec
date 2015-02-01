# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'terminal_paint/version'

Gem::Specification.new do |spec|
  spec.name          = "terminal_paint"
  spec.version       = TerminalPaint::VERSION
  spec.authors       = ["Bruno Bonamin"]
  spec.email         = ["bruno@bonamin.org"]
  spec.summary       = %q{A basic interactive bitmap editor for the terminal.}
  spec.description   = %q{A basic interactive bitmap editor for the terminal. Paint a canvas with different colors, drawing lines and filling regions.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rubocop", "~> 0.28"
end
