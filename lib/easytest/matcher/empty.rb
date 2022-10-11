module Easytest
  module Matcher
    class Empty < Base
      def match?
        actual.empty?
      end

      def message
        "empty"
      end
    end
  end
end
