require "bundler/gem_tasks"
require "rubocop/rake_task"
require "rdoc/task"

task default: %i[lint test]

desc "Run lint"
task lint: %i[rubocop rbs:setup typecheck:run typecheck:stats rdoc]

RuboCop::RakeTask.new

RDoc::Task.new do |rdoc|
  rdoc.main = "README.md"
  rdoc.rdoc_dir = "doc"
  rdoc.rdoc_files.include("README.md", "sig")
  rdoc.options << "--encoding=UTF-8"
end

desc "Run test"
task :test do
  sh "easytest"
end

namespace :typecheck do
  desc "Run type-check"
  task :run do
    sh "steep check --with-expectations"
  end

  desc "Run type-check saving expectations"
  task :save do
    sh "steep check --save-expectations"
  end

  desc "Show type coverage stats"
  task :stats do
    sh "steep stats --format=table"
  end
end

namespace :rbs do
  desc "Set up RBS"
  task :setup do
    sh "rbs collection install"
  end

  desc "Generate RBS"
  task :generate do
    require "pathname"

    ignored = %w[lib/easytest/version.rb]

    Pathname.glob("lib/**/*.rb") do |infile|
      if ignored.include? infile.to_s
        puts "Ignored: #{infile}"
        next
      end

      outfile = Pathname(infile.to_s.sub(/^lib/, "sig/_internal").sub(/\.rb$/, ".rbs"))
      outfile.parent.mkpath
      sh "rbs prototype rb #{infile} > #{outfile}"
    end
  end
end
