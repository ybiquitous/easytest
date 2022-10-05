module Easytest
  module Matcher
    class InstanceOf < Base
      def match?
        actual.instance_of? expected
      end

      def message
        "instance of"
      end
    end
  end
end
