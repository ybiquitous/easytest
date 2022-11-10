require "test_helper"
require "open3"
require "pathname"
require "tempfile"

extend Easytest::DSL

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
  -w, --watch    Watch file changes and rerun test
  --help         Show help
  --version      Show version

EXAMPLES
  # Run all tests (test/**/*_test.rb)
  $ easytest

  # Run only test files
  $ easytest test/example_test.rb

  # Run only test files in given directories
  $ easytest test/example

  # Run only test files that matches given patterns
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

def run_with(file:)
  code = Pathname(__dir__).join(file).read
  tmpfile = Pathname(__dir__).join("#{Time.now.to_i}_cli_test.rb")
  tmpfile.write(code)
  result = run("easytest #{tmpfile}")
  [*result, tmpfile]
ensure
  tmpfile.delete
end

test "show case results" do
  stdout, stderr, status, file = run_with(file: "fixtures/show_case_results.rb")
  expect(stdout).to_include <<-MSG.strip
 FAIL  \e]8;;file://#{file}\e\\test/#{file.basename}\e]8;;\e\\
  ✎ todo "todo"
  ⚠ skipped "skipped"
  ✕ failed  (equal)

    Expected: 0
    Received: 1

    # test/#{file.basename}:9:in `block in <top (required)>'


 Tests:  1 failed, 1 skipped, 1 todo, 1 passed, 4 total (1 file)
MSG
  expect(stderr).to_eq ""
  expect(status).to_eq 1
end

test "run only case" do
  stdout, stderr, status, file = run_with(file: "fixtures/run_only_case.rb")
  expect(stdout).to_include <<-MSG
 PASS  \e]8;;file://#{file}\e\\test/#{file.basename}\e]8;;\e\\
  ⚠ skipped "should not run this case"
  ⚠ skipped "skipped"

 Tests:  2 skipped, 2 passed, 4 total (1 file)
MSG
  expect(stderr).to_eq ""
  expect(status).to_eq 0
end

test "hooks" do
  stdout, stderr, status, file = run_with(file: "fixtures/hooks.rb")
  expect(stdout).to_include <<-MSG
 FAIL  \e]8;;file://#{file}\e\\test/#{file.basename}\e]8;;\e\\
  ✕ second  (equal)

    Expected: 2
    Received: 1

    # test/#{file.basename}:15:in `block in <top (required)>'


 Tests:  1 failed, 1 passed, 2 total (1 file)
MSG
  expect(stderr).to_eq ""
  expect(status).to_eq 1
end

test "watch mode" do
  # TODO: This `if` avoids "Terminate batch job (Y/N)?" prompt,
  # but I'd like to test the case also on Windows.
  next if Gem.win_platform?

  stdout = Tempfile.create("easytest_cli_test_stdout", __dir__)
  stderr = Tempfile.create("easytest_cli_test_stderr", __dir__)

  pid = Process.spawn("easytest --watch", out: stdout, err: stderr)
  Thread.start(pid) do |pid_in_thread|
    sleep 1
    Process.kill("INT", pid_in_thread)
  end
  Process.wait(pid)

  expect(File.read(stdout)).to_match "Start watching"
  expect(File.read(stderr)).to_eq ""
ensure
  File.unlink(stdout) if stdout
  File.unlink(stderr) if stderr
end
