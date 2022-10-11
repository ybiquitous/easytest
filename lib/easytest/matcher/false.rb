module Easytest
  module Matcher
    class False < Base
      def match?
        actual == expected
      end

      def message
        "false"
      end
    end
  end
end
