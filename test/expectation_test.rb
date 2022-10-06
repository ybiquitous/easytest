require "test_helper"

using Easytest::DSL

def subject(actual)
  Easytest::Expectation.new(actual)
end

test "to_eq" do
  expect { subject("foo").to_eq("foo") }.to_not_raise
  expect { subject("foo").to_eq("bar") }.to_raise "equal"
end

test "not.to_eq" do
  expect { subject("foo").not.to_eq("bar") }.to_not_raise
  expect { subject("foo").not.to_eq("foo") }.to_raise "not equal"
end

test "to_equal" do
  expect { subject(1).to_equal(1) }.to_not_raise
  expect { subject(1).to_equal(0) }.to_raise "equal"
end

test "to_be" do
  expect { subject(true).to_be(true) }.to_not_raise
  expect { subject(true).to_be(false) }.to_raise "same"
end

test "not.to_be" do
  expect { subject(true).not.to_be(false) }.to_not_raise
  expect { subject(true).not.to_be(true) }.to_raise "not same"
end

test "to_be_nil" do
  expect { subject(nil).to_be_nil }.to_not_raise
  expect { subject(false).to_be_nil }.to_raise "nil"
end

test "not.to_be_nil" do
  expect { subject(false).not.to_be_nil }.to_not_raise
  expect { subject(nil).not.to_be_nil }.to_raise "not nil"
end

test "to_be_true" do
  expect { subject(true).to_be_true }.to_not_raise
  expect { subject(false).to_be_true }.to_raise "true"
end

test "not.to_be_true" do
  expect { subject(false).not.to_be_true }.to_not_raise
  expect { subject(true).not.to_be_true }.to_raise "not true"
end

test "to_be_false" do
  expect { subject(false).to_be_false }.to_not_raise
  expect { subject(true).to_be_false }.to_raise "false"
end

test "not.to_be_false" do
  expect { subject(true).not.to_be_false }.to_not_raise
  expect { subject(false).not.to_be_false }.to_raise "not false"
end

test "to_be_a" do
  expect { subject("foo").to_be_a String }.to_not_raise
  expect { subject("foo").to_be_a Integer }.to_raise "be a"
end

test "not.to_be_a" do
  expect { subject("foo").not.to_be_a Integer }.to_not_raise
  expect { subject("foo").not.to_be_a String }.to_raise "not be a"
end

test "to_be_kind_of" do
  expect { subject("foo").to_be_kind_of String }.to_not_raise
  expect { subject("foo").to_be_kind_of Integer }.to_raise "kind of"
end

test "not.to_be_kind_of" do
  expect { subject("foo").not.to_be_kind_of Integer }.to_not_raise
  expect { subject("foo").not.to_be_kind_of String }.to_raise "not kind of"
end

test "to_be_instance_of" do
  expect { subject("foo").to_be_instance_of String }.to_not_raise
  expect { subject("foo").to_be_instance_of Object }.to_raise "instance of"
end

test "not.to_be_instance_of" do
  expect { subject("foo").not.to_be_instance_of Object }.to_not_raise
  expect { subject("foo").not.to_be_instance_of String }.to_raise "not instance of"
end

test "to_include" do
  expect { subject("foo").to_include "f" }.to_not_raise
  expect { subject("foo").to_include "b" }.to_raise "include"

  expect { subject(["foo"]).to_include "foo" }.to_not_raise
  expect { subject(["foo"]).to_include "bar" }.to_raise "include"
end

test "not.to_include" do
  expect { subject("foo").not.to_include "b" }.to_not_raise
  expect { subject("foo").not.to_include "f" }.to_raise "not include"
end

test "to_match" do
  expect { subject("foo").to_match %r{f} }.to_not_raise
  expect { subject("foo").to_match %r{b} }.to_raise "match"

  expect { subject(/^fo/).to_match "foo" }.to_not_raise
  expect { subject(/^fo/).to_match "bar" }.to_raise "match"
end

test "not.to_match" do
  expect { subject("foo").not.to_match %r{b} }.to_not_raise
  expect { subject("foo").not.to_match %r{f} }.to_raise "not match"
end

def subject_block(&block)
  Easytest::Expectation.new(nil, &block)
end

raise_thing = -> { raise "foo" }
noop = -> {}

test "to_raise" do
  expect { subject_block(&raise_thing).to_raise RuntimeError }.to_not_raise
  expect { subject_block(&noop).to_raise RuntimeError }.to_raise "raise"

  expect { subject_block(&raise_thing).to_raise "foo" }.to_not_raise
  expect { subject_block(&noop).to_raise "bar" }.to_raise "raise"

  expect { subject_block(&raise_thing).to_raise %r{fo} }.to_not_raise
  expect { subject_block(&noop).to_raise %r{ba} }.to_raise "raise"

  expect { subject("foo").to_raise "foo" }.to_raise "`to_raise` requires a block like `expect { ... }.to_raise`"
  expect { subject_block(&noop).not.to_raise "foo" }.to_raise "`not.to_raise` can cause a false positive, so use `to_not_raise` instead"
  expect { subject_block(&noop).to_raise 123 }.to_raise "`to_raise` requires a Class, String, or Regexp"
end

test "not.to_raise" do
  expect { subject_block(&noop).not.to_raise "anything" }
    .to_raise "`not.to_raise` can cause a false positive, so use `to_not_raise` instead"
end

test "to_not_raise" do
  expect { subject_block(&noop).to_not_raise }.to_not_raise
  expect { subject_block(&raise_thing).to_not_raise }.to_raise "not raise"

  expect { subject("foo").to_not_raise }.to_raise "`to_not_raise` requires a block like `expect { ... }.to_not_raise`"
end
