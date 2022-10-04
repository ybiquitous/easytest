module Easytest
  module Matcher
    class Equal < Base
      attr_reader :expected

      def initialize(actual:, expected:)
        super(actual: actual)
        @expected = expected
      end

      def match?
        actual == expected
      end

      def match!
        unless match?
          raise UnmatchedError.new(message: "should equal (==)", actual: actual, expected: expected)
        end
      end
    end
  end
end
