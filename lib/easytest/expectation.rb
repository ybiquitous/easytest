module Easytest
  class Expectation
    attr_reader :actual
    attr_reader :block
    attr_reader :negate

    def initialize(actual, negate: false, &block)
      @actual = actual
      @block = block
      @negate = negate
    end

    def not
      self.class.new(actual, negate: true, &block)
    end

    def to_eq(expected)
      Matcher::Equal.new(actual: actual, expected: expected, negate: negate).match!
    end
    alias to_equal to_eq

    def to_be(expected)
      Matcher::Be.new(actual: actual, expected: expected, negate: negate).match!
    end

    def to_be_nil
      Matcher::Nil.new(actual: actual, negate: negate).match!
    end

    def to_be_true
      Matcher::True.new(actual: actual, negate: negate).match!
    end

    def to_be_false
      Matcher::False.new(actual: actual, negate: negate).match!
    end

    def to_be_a(expected)
      Matcher::BeA.new(actual: actual, expected: expected, negate: negate).match!
    end

    def to_be_kind_of(expected)
      Matcher::KindOf.new(actual: actual, expected: expected, negate: negate).match!
    end

    def to_be_instance_of(expected)
      Matcher::InstanceOf.new(actual: actual, expected: expected, negate: negate).match!
    end

    def to_raise(exception_class)
      Matcher::Raise.new(actual: block, expected: exception_class, negate: negate).match!
    end

    def to_not_raise
      Matcher::NotRaise.new(actual: block).match!
    end
  end
end
