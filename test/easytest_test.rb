require "test_helper"

using Easytest::DSL

test "to_eq pass" do
  expect("foo").to_eq "foo"
end

test "to_eq fail" do
  expect("foo").to_eq "bar"
end

test "to_be_nil pass" do
  expect(nil).to_be_nil
end

test "to_be_nil fail" do
  expect("foo").to_be_nil
end
