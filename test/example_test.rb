require "easytest"

using Easytest::DSL

test "simple addition" do
  expect(1 + 1).to_eq 2
end

test "even number" do
  expect(2.even?).to_be true
  expect(1.even?).to_be false
end
