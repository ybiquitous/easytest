module Easytest
  module Matcher
    class KindOf < Base
      def match?
        actual.kind_of? expected
      end

      def message
        "kind of"
      end
    end
  end
end
