module Easytest
  module Matcher
    class Be < Base
      attr_reader :expected

      def initialize(actual:, expected:)
        super(actual: actual)
        @expected = expected
      end

      def match?
        actual.equal? expected
      end

      def match!
        unless match?
          raise UnmatchedError.new(message: "should be same", actual: actual, expected: expected)
        end
      end
    end
  end
end
