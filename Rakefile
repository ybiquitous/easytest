require "bundler/gem_tasks"
require "rubocop/rake_task"
require "rdoc/task"

RuboCop::RakeTask.new

RDoc::Task.new do |rdoc|
  rdoc.main = "README.md"
  rdoc.rdoc_dir = "doc/"
  rdoc.rdoc_files.include("README.md", "sig")
end

desc "Run test"
task :test do
  sh "exe/easytest"
end

desc "Run type-check"
task :typecheck do
  sh "steep check --with-expectations"
end

task default: %i[test rubocop typecheck rdoc]
