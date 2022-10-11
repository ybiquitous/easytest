module Easytest
  module Matcher
    class Nil < Base
      def match?
        actual.nil?
      end

      def message
        "nil"
      end
    end
  end
end
