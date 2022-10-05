module Easytest
  module Matcher
    class BeFalse < Base
      def initialize(actual:, negate:)
        super(actual: actual, expected: false, negate: negate)
      end

      def match?
        actual == expected
      end

      def message
        "be false"
      end
    end
  end
end
