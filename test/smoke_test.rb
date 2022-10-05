require "easytest"

using Easytest::DSL

test "simple case" do
  expect(1 + 2).to_eq 3
  expect(1 + 2).not.to_equal 4

  expect(nil).to_be_nil
  expect(" ").not.to_be_nil

  expect("").to_be_a String
  expect(12).not.to_be_a String

  expect { 1 / 0 }.to_raise ZeroDivisionError
  expect { 1 / 2 }.to_not_raise
end
