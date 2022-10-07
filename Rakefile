require "bundler/gem_tasks"
require "rubocop/rake_task"

RuboCop::RakeTask.new

desc "Run test"
task :test do
  sh "exe/easytest"
end

desc "Run type-check"
task :typecheck do
  sh "steep check --with-expectations"
end

desc "Generate documents"
task :doc do
  sh "rdoc sig"
end

task default: %i[test rubocop typecheck doc]
