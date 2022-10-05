module Easytest
  module Matcher
    class Raise < Base
      def initialize(...)
        super(...)

        raise ArgumentError, "block is required" unless actual
      end

      def match?
        begin
          actual.call
          false
        rescue => error
          @raised_error = error
          match_error?(actual: error, expected: expected)
        end
      end

      def raise_match_error
        raise MatchError.new(message: build_error_message, actual: @raised_error, expected: expected)
      end

      def message
        "raise"
      end

      private

      def match_error?(actual:, expected:)
        case expected
        when Class
          actual.class == expected
        when String
          actual.message == expected
        when Regexp
          actual.message.match? expected
        else
          raise TypeError.new "Class, String, or Regexp is allowed: #{expected}"
        end
      end
    end
  end
end