module Easytest
  module Matcher
    class Be < Base
      def match?
        actual.equal? expected
      end

      def message
        "be same"
      end
    end
  end
end
