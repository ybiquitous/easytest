require "easytest"

using Easytest::DSL

test "simple case" do
  expect(1 + 2).to_eq 3
  expect(1 + 2).not.to_equal 4
  expect(false).to_be false
  expect(nil).to_be_nil
  expect(false).to_be_false
  expect(true).to_be_true
  expect("s").to_be_a String
  expect(123).to_be_kind_of Numeric
  expect(123).to_be_instance_of Integer
  expect({ a: 1 }).to_include :a
  expect(/^fo/).to_match "foo"
  expect { 1 / 0 }.to_raise ZeroDivisionError
  expect { 1 / 2 }.to_not_raise
end

test "add something later"

skip "failed case" do
  expect(1).to_eq 0
end
