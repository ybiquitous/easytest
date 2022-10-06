module Easytest
  module Matcher
    class Match < Base
      def match?
        actual.match? expected
      end

      def message
        "match"
      end
    end
  end
end
