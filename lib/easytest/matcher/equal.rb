module Easytest
  module Matcher
    class Equal < Base
      def match?
        actual == expected
      end

      def message
        "equal"
      end
    end
  end
end
