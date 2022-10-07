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
  easytest [options] [<file, directory, or pattern>...]

OPTIONS
  --help      Show help
  --version   Show version

EXAMPLES
  # Run all tests (test/**/*_test.rb)
  $ easytest

  # Run only test files
  $ easytest test/example_test.rb

  # Run only test files in specified directories
  $ easytest test/example

  # Run only test files that matches specified patterns
  $ easytest example
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

def run_with_code(code)
  basename = "#{Time.now.to_i}_cli_test.rb"
  tmpfile = File.join(__dir__, basename)
  File.write(tmpfile, code)
  result = run("easytest #{tmpfile}")
  result << tmpfile
ensure
  File.unlink(tmpfile)
end

test "show case results" do
  code = <<-RUBY
require "easytest"
using Easytest::DSL
test "passed" do expect(1).to_eq 1 end
test "failed" do expect(1).to_eq 0 end
test "todo"
skip "skipped" do end
RUBY

  stdout, stderr, status, file = run_with_code(code)
  basename = File.basename(file)
  expect(stdout).to_include <<-MSG.strip
 FAIL  \e]8;;file://#{file}\e\\test/#{basename}\e]8;;\e\\
  ✎ todo "todo"
  ⚠ skipped "skipped"
  ✕ failed  (equal)

    Expected: 0
    Received: 1

    # test/#{basename}:4:in `block in <top (required)>'


 Tests:  1 failed, 1 skipped, 1 todo, 1 passed, 4 total (1 file)
MSG
  expect(stderr).to_eq ""
  expect(status).to_eq 1
end

test "run only case" do
  code = <<-RUBY
require "easytest"
using Easytest::DSL
only "case 1" do end
only "case 2" do end
test "should not run this case" do raise end
skip "skipped" do raise end
RUBY

  stdout, stderr, status, file = run_with_code(code)
  basename = File.basename(file)
  expect(stdout).to_include <<-MSG
 PASS  \e]8;;file://#{file}\e\\test/#{basename}\e]8;;\e\\
  ⚠ skipped "should not run this case"
  ⚠ skipped "skipped"

 Tests:  2 skipped, 2 passed, 4 total (1 file)
MSG
  expect(stderr).to_eq ""
  expect(status).to_eq 0
end
