require "test_helper"

using Easytest::DSL

subject = Easytest::Matcher::Equal

test "Easytest::Matcher::Equal#match?" do
  expect(subject.new(actual: "foo", expected: "foo").match?).to_be true
  expect(subject.new(actual: "foo", expected: "bar").match?).to_be false
end
