module Easytest
  module Matcher
    class Base
      attr_reader :actual
      attr_reader :expected
      attr_reader :negate
      alias negate? negate

      def initialize(actual:, expected:, negate: false)
        @actual = actual
        @expected = expected
        @negate = negate
      end

      def match?
        raise NotImplementedError
      end

      def match!
        matched = match?
        matched = !matched if negate?
        raise_match_error unless matched
      end

      private

      def message
        raise NotImplementedError
      end

      def build_error_message
        prefix = negate? ? "not " : ""
        "#{prefix}#{message}"
      end

      def raise_match_error
        raise MatchError.new(message: build_error_message, actual: actual, expected: expected)
      end
    end
  end
end
