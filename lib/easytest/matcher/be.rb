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

      def message
        "should be same"
      end
    end
  end
end
