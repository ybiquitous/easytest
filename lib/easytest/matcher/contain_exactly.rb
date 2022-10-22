module Easytest
  module Matcher
    class ContainExactly < Base
      def match?
        (Array(actual) - Array(expected)).empty?
      end

      def message
        "contain exactly"
      end
    end
  end
end
