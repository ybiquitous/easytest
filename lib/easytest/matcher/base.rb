module Easytest
  module Matcher
    class Base
      attr_reader :actual

      def initialize(actual:)
        @actual = actual
      end

      def match?
        raise NotImplementedError
      end

      def match!
        unless match?
          raise UnmatchedError.new(message: message, actual: actual, expected: expected)
        end
      end

      def expected
        raise NotImplementedError
      end

      def message
        raise NotImplementedError
      end
    end
  end
end
