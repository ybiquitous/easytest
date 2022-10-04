require "test_helper"

using Easytest::DSL

test "to_eq" do
  expect("foo").to_eq "bar"
end

test "to_be_nil" do
  expect("foo").to_be_nil
end
