require "test_helper"

using Easytest::DSL

subject = Easytest::Matcher::Be

test "Easytest::Matcher::Be#match?" do
  a = Object.new
  b = Object.new
  expect(subject.new(actual: a, expected: a).match?).to_be true
  expect(subject.new(actual: a, expected: b).match?).to_be false
end
