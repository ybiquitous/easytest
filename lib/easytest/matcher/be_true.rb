module Easytest
  module Matcher
    class BeTrue < Base
      def initialize(actual:, negate:)
        super(actual: actual, expected: true, negate: negate)
      end

      def match?
        actual == expected
      end

      def message
        "be true"
      end
    end
  end
end
