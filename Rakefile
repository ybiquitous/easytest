require "bundler/gem_tasks"
require "rubocop/rake_task"
require "rdoc/task"

task default: %i[lint test]

RuboCop::RakeTask.new

RDoc::Task.new do |rdoc|
  rdoc.main = "README.md"
  rdoc.rdoc_dir = "doc"
  rdoc.rdoc_files.include("README.md", "sig")
end

desc "Run test"
task :test do
  sh "easytest"
end

desc "Run type-check"
task :typecheck do
  sh "steep check --with-expectations"
end

desc "Run lint"
task lint: %i[rubocop typecheck rdoc]

desc "Generate private RBS"
task :rbs_private do
  require "pathname"

  ignored = %w[lib/easytest/version.rb]

  Pathname.glob("lib/**/*.rb") do |infile|
    if ignored.include? infile.to_s
      puts "Ignored: #{infile}"
      next
    end

    outfile = Pathname(infile.to_s.sub(/^lib/, "sig-private").sub(/\.rb$/, ".rbs"))
    outfile.parent.mkpath
    sh "rbs prototype rb #{infile} > #{outfile}"
  end
end
