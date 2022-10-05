module Easytest
  module Matcher
    class BeA < Base
      def match?
        actual.is_a? expected
      end

      def message
        "be a"
      end
    end
  end
end
