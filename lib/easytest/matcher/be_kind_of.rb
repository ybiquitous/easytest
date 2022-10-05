module Easytest
  module Matcher
    class BeKindOf < Base
      def match?
        actual.kind_of? expected
      end

      def message
        "be a kind of <class>"
      end
    end
  end
end
