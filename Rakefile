require "bundler/gem_tasks"
require "rubocop/rake_task"

RuboCop::RakeTask.new

desc "Run test"
task :test do
  sh "exe/easytest"
end

desc "Run type-check"
task :typecheck do
  sh "bin/steep check --with-expectations"
end

task default: %i[test rubocop typecheck]
