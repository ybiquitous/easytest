module Easytest
  module Matcher
    class BeNil < Base
      def initialize(actual:, negate:)
        super(actual: actual, expected: nil, negate: negate)
      end

      def match?
        actual.nil?
      end

      def message
        "be nil"
      end
    end
  end
end
