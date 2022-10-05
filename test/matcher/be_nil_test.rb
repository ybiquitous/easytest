require "test_helper"

using Easytest::DSL

subject = Easytest::Matcher::BeNil

test "Easytest::Matcher::BeNil#match?" do
  expect(subject.new(actual: nil).match?).to_be true
  expect(subject.new(actual: "foo").match?).to_be false
end
