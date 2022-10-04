module Easytest
  module Matcher
    class BeNil < Base
      def match?
        actual.nil?
      end

      def match!
        unless match?
          raise UnmatchedError.new(message: "should be `nil`", actual: actual, expected: nil)
        end
      end
    end
  end
end
