require "bundler/gem_tasks"
require "rubocop/rake_task"

RuboCop::RakeTask.new

desc "Run test"
task :test do
  sh "exe/easytest"
end


task default: %i[test rubocop]
