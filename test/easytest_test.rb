require "test_helper"

using Easytest::DSL

test "`to_eq` passes" do
  expect("foo").to_eq "foo"
end

test "`to_eq` fails" do
  expect("foo").to_eq "bar"
end

test "`to_be` passes" do
  obj = Object.new
  expect(obj).to_be obj
end

test "`to_be` fails" do
  expect(Object.new).to_be Object.new
end

test "`to_be_nil` passes" do
  expect(nil).to_be_nil
end

test "`to_be_nil` fails" do
  expect("foo").to_be_nil
end
