module Easytest
  module Matcher
    class BeNil < Base
      def match?
        actual.nil?
      end

      def expected
        nil
      end

      def message
        "should be nil"
      end
    end
  end
end
