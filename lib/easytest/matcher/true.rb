module Easytest
  module Matcher
    class True < Base
      def match?
        actual == expected
      end

      def message
        "true"
      end
    end
  end
end
