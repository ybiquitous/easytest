module Easytest
  class Expectation
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

    def to_include(expected)
      Matcher::Include.new(actual: actual, expected: expected, negate: negate).match!
    end

    def to_raise(expected)
      raise FatalError, "`to_raise` requires a block like `expect { ... }.to_raise`" unless block
      raise FatalError, "`not.to_raise` can cause a false positive, so use `to_not_raise` instead" if negate?
      raise FatalError, "`to_raise` requires a Class, String, or Regexp" unless [Class, String, Regexp].any? { expected.is_a? _1 }

      Matcher::Raise.new(actual: block, expected: expected, negate: negate).match!
    end

    def to_not_raise
      raise FatalError, "`to_not_raise` requires a block like `expect { ... }.to_not_raise`" unless block

      Matcher::NotRaise.new(actual: block).match!
    end

    private

    attr_reader :actual
    attr_reader :block
    attr_reader :negate
    alias negate? negate

    def initialize(actual, negate: false, &block)
      @actual = actual
      @block = block
      @negate = negate
    end
  end
end
