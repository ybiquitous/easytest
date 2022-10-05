module Easytest
  module Matcher
    class NotRaise < Base
      def initialize(actual:)
        super(actual: actual, expected: nil)

        raise ArgumentError, "block is required" unless actual
      end

      def match?
        begin
          actual.call
          true
        rescue => error
          @raised_error = error
          false
        end
      end

      def raise_match_error
        raise MatchError.new(message: build_error_message, actual: @raised_error, expected: expected)
      end

      def message
        "not raise"
      end
    end
  end
end
