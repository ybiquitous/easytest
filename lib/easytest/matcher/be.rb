module Easytest
  module Matcher
    class Be < Base
      def match?
        actual.equal? expected
      end

      def message
        "same"
      end
    end
  end
end
