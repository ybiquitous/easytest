require "easytest"

using Easytest::DSL

test "simple addition" do
  expect(1 + 1).to_eq 2
end
