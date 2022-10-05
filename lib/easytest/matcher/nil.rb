module Easytest
  module Matcher
    class Nil < Base
      def initialize(actual:, negate:)
        super(actual: actual, expected: nil, negate: negate)
      end

      def match?
        actual.nil?
      end

      def message
        "nil"
      end
    end
  end
end
