module Easytest
  class Expectation
    attr_reader :actual
    attr_reader :block

    def initialize(actual, &block)
      @actual = actual
      @block = block
    end

    def to_eq(expected)
      Matcher::Equal.new(actual: eval_actual, expected: expected).match!
    end

    def to_be(expected)
      Matcher::Be.new(actual: eval_actual, expected: expected).match!
    end

    def to_be_nil
      Matcher::BeNil.new(actual: eval_actual).match!
    end

    def to_raise(exception_class)

    end

    def to_not_raise(exception_class)

    end

    private

    def eval_actual
      if block
        block.call
      else
        actual
      end
    end
  end
end
