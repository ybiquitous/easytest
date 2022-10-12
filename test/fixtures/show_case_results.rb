require "easytest"
using Easytest::DSL

test "passed" do
  expect(1).to_eq 1
end

test "failed" do
  expect(1).to_eq 0
end

test "todo"

skip "skipped" do
  # ...
end
