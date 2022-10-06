require "test_helper"
require "open3"

using Easytest::DSL

def run(cmd)
  stdout, stderr, status = Open3.capture3(cmd)
  [stdout, stderr, status.exitstatus]
end

test "show help" do
  stdout, stderr, status = run("easytest --help")
  expect(stdout).to_eq <<-MSG
USAGE
  easytest [options] [...<file, directory, or pattern>]

OPTIONS
  --help      Show help
  --version   Show version
MSG
  expect(stderr).to_eq ""
  expect(status).to_eq 0
end

test "show version" do
  stdout, stderr, status = run("easytest --version")
  expect(stdout).to_eq "easytest #{Easytest::VERSION}\n"
  expect(stderr).to_eq ""
  expect(status).to_eq 0
end

test "invalid option" do
  stdout, stderr, status = run("easytest --foo")
  expect(stdout).to_eq ""
  expect(stderr).to_eq "invalid option: --foo\n"
  expect(status).to_eq 2
end

test "no tests" do
  stdout, stderr, status = run("easytest foo/bar")
  expect(stdout).to_eq ""
  expect(stderr).to_eq <<-MSG
Oops. No tests found!

Put `test/**/*_test.rb` files to include at least one test case.
Or specify a pattern that matches an existing test file.
MSG
  expect(status).to_eq 1
end
