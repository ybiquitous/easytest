module Easytest
  module Matcher
    class BeInstanceOf < Base
      def match?
        actual.instance_of? expected
      end

      def message
        "be an instance of <class>"
      end
    end
  end
end
