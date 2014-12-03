# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'scbi_fastq/version'

Gem::Specification.new do |spec|
  spec.name          = "scbi_fastq"
  spec.version       = ScbiFastq::VERSION
  spec.authors       = ["dariogf"]
  spec.email         = ["dariogf@scbi.uma.es"]
  spec.summary       = %q{read/write FASTQ files}
  spec.description   = %q{scbi_fastq is a ruby gem to read/write FASTQ files (DNA/RNA sequences) with qualities in a variety of formats (Sanger, Solexa, Ilumina).}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "scbi_multi_gz_reader"
  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
