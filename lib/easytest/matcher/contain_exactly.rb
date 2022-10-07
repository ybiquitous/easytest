module Easytest
  module Matcher
    class ContainExactly < Base
      def match?
        (actual.to_a - expected).empty?
      end

      def message
        "contain exactly"
      end
    end
  end
end
