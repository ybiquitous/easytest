module Easytest
  module Matcher
    class Raise < Base
      attr_reader :with_message

      def initialize(actual:, expected:, negate:, with_message:)
        super(actual: actual, expected: expected, negate: negate)
        @with_message = with_message
      end

      def match?
        begin
          actual.call
          false
        rescue => error
          @raised_error = error
          match_error?(error)
        end
      end

      def raise_match_error
        raise MatchError.new(message: build_error_message, actual: @raised_error, expected: expected)
      end

      def message
        "raise"
      end

      private

      def match_error?(error)
        case expected
        when Class
          matched = error.class == expected
          if with_message
            matched && error.message.match?(with_message)
          else
            matched
          end
        when String
          error.message == expected
        when Regexp
          error.message.match? expected
        else
          false
        end
      end
    end
  end
end
