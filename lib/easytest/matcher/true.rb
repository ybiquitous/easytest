module Easytest
  module Matcher
    class True < Base
      def initialize(actual:, negate:)
        super(actual: actual, expected: true, negate: negate)
      end

      def match?
        actual == expected
      end

      def message
        "true"
      end
    end
  end
end
