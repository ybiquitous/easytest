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
  expect([]).to_be_empty
  expect({ a: 1 }).to_include :a
  expect(/^fo/).to_match "foo"
  expect(1..4).to_contain_exactly 1, 3, 4, 2
  expect("あ").to_have_attributes size: 1, bytesize: 3
  expect(2).to_satisfy { |n| n > 1 }
  expect { 1 / 0 }.to_raise ZeroDivisionError
  expect { 1 / 0 }.to_raise ZeroDivisionError, "divided"
  expect { 1 / 2 }.to_raise_nothing
end

before do |c|
  puts "Running a test case \"#{c.name}\"..."
end

after do |c|
  puts "Finished a test case \"#{c.name}\"..."
end

test "add something later"

skip "failed case" do
  expect(1).to_eq 0
end

if false # rubocop:disable Lint/LiteralAsCondition -- For type-checking
  only "this case" do
    expect(1.0).to_be_a Float
  end
end
