require_relative "lib/easytest/version"

Gem::Specification.new do |spec|
  spec.name = "easytest"
  spec.version = Easytest::VERSION
  spec.authors = ["Masafumi Koba"]
  spec.email = ["473530+ybiquitous@users.noreply.github.com"]

  spec.summary = "Easy testing in Ruby."
  spec.description = "Easy testing in Ruby."
  spec.homepage = "https://github.com/ybiquitous/easytest"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/main/CHANGELOG.md"

  spec.metadata["rubygems_mfa_required"] = "true"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rainbow", ">= 3.1"
end
