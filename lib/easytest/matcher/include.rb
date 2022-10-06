module Easytest
  module Matcher
    class Include < Base
      def match?
        actual.include? expected
      end

      def message
        "include"
      end
    end
  end
end
