module Easytest
  module Matcher
    class False < Base
      def initialize(actual:, negate:)
        super(actual: actual, expected: false, negate: negate)
      end

      def match?
        actual == expected
      end

      def message
        "false"
      end
    end
  end
end
