module Easytest
  class Expectation
    def initialize(actual)
      @actual = actual
    end

    def to_eq(expected)
      Matcher::Equal.new(actual: @actual, expected: expected).match!
    end

    def to_be(expected)
      Matcher::Be.new(actual: @actual, expected: expected).match!
    end

    def to_be_nil
      Matcher::BeNil.new(actual: @actual).match!
    end
  end
end
