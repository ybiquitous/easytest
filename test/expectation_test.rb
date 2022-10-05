require "test_helper"

using Easytest::DSL

def subject(actual)
  Easytest::Expectation.new(actual)
end

test "to_eq" do
  expect { subject("foo").to_eq("foo") }.to_not_raise
  expect { subject("foo").to_eq("bar") }.to_raise %r{should equal}

  expect { subject("foo").not.to_eq("bar") }.to_not_raise
  expect { subject("foo").not.to_eq("foo") }.to_raise %r{should not equal}
end

test "to_be" do
  expect { subject(true).to_be(true) }.to_not_raise
  expect { subject(true).to_be(false) }.to_raise %r{should be same}

  expect { subject(true).not.to_be(false) }.to_not_raise
  expect { subject(true).not.to_be(true) }.to_raise %r{should not be same}
end

test "to_be_nil" do
  expect { subject(nil).to_be_nil }.to_not_raise
  expect { subject(false).to_be_nil }.to_raise %r{should be nil}

  expect { subject(false).not.to_be_nil }.to_not_raise
  expect { subject(nil).not.to_be_nil }.to_raise %r{should not be nil}
end

test "to_be_true" do
  expect { subject(true).to_be_true }.to_not_raise
  expect { subject(false).to_be_true }.to_raise %r{should be true}

  expect { subject(false).not.to_be_true }.to_not_raise
  expect { subject(true).not.to_be_true }.to_raise %r{should not be true}
end

test "to_be_false" do
  expect { subject(false).to_be_false }.to_not_raise
  expect { subject(true).to_be_false }.to_raise %r{should be false}

  expect { subject(true).not.to_be_false }.to_not_raise
  expect { subject(false).not.to_be_false }.to_raise %r{should not be false}
end

test "to_be_a" do
  expect { subject("foo").to_be_a String }.to_not_raise
  expect { subject("foo").to_be_a Integer }.to_raise %r{should be a <class>}

  expect { subject("foo").not.to_be_a Integer }.to_not_raise
  expect { subject("foo").not.to_be_a String }.to_raise %r{should not be a <class>}
end

test "to_be_kind_of" do
  expect { subject("foo").to_be_kind_of String }.to_not_raise
  expect { subject("foo").to_be_kind_of Integer }.to_raise %r{should be a kind of <class>}

  expect { subject("foo").not.to_be_kind_of Integer }.to_not_raise
  expect { subject("foo").not.to_be_kind_of String }.to_raise %r{should not be a kind of <class>}
end

test "to_be_instance_of" do
  expect { subject("foo").to_be_instance_of String }.to_not_raise
  expect { subject("foo").to_be_instance_of Object }.to_raise %r{should be an instance of <class>}

  expect { subject("foo").not.to_be_instance_of Object }.to_not_raise
  expect { subject("foo").not.to_be_instance_of String }.to_raise %r{should not be an instance of <class>}
end

def subject_block(&block)
  Easytest::Expectation.new(nil, &block)
end

test "to_raise" do
  raise_block = -> { raise "foo" }
  not_raise_block = -> {}

  expect { subject_block(&raise_block).to_raise RuntimeError }.to_not_raise
  expect { subject_block(&not_raise_block).to_raise RuntimeError }.to_raise %r{should raise}

  expect { subject_block(&raise_block).to_raise "foo" }.to_not_raise
  expect { subject_block(&not_raise_block).to_raise "bar" }.to_raise %r{should raise}

  expect { subject_block(&raise_block).to_raise %r{fo} }.to_not_raise
  expect { subject_block(&not_raise_block).to_raise %r{ba} }.to_raise %r{should raise}
end

test "to_not_raise" do
  raise_block = -> { raise "foo" }
  not_raise_block = -> {}

  expect { subject_block(&not_raise_block).to_not_raise }.to_not_raise
  expect { subject_block(&raise_block).to_not_raise }.to_raise %{should not raise}
end
