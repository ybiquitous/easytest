require_relative "lib/easytest/version"

Gem::Specification.new do |spec|
  spec.name = "easytest"
  spec.version = Easytest::VERSION
  spec.authors = ["Masafumi Koba"]
  spec.email = ["ybiquitous@gmail.com"]
  spec.license = "MIT"

  spec.summary = "Easy testing for Ruby."
  spec.description = "Easytest is a tiny testing framework for Ruby with a familiar DSL."
  spec.homepage = "https://ybiquitous.github.io/easytest/"
  spec.required_ruby_version = ">= 2.7"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/ybiquitous/easytest"
  spec.metadata["changelog_uri"] = "https://github.com/ybiquitous/easytest/blob/main/CHANGELOG.md"
  spec.metadata["rubygems_mfa_required"] = "true"

  spec.files = Dir["CHANGELOG.md", "LICENSE", "README.md", "exe/*", "lib/**/*.rb", "sig/**/*.rbs"]
  spec.bindir = "exe"
  spec.executables = ["easytest"]
  spec.require_paths = ["lib"]

  spec.add_dependency "listen", ">= 3.7"
  spec.add_dependency "rainbow", ">= 3.1"
end
