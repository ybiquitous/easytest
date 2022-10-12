module Easytest
  module Matcher
    class Satisfy < Base
      def match?
        expected.call(actual) == true
      end

      def message
        "satisfy"
      end
    end
  end
end
