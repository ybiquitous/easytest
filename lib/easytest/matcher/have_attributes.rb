module Easytest
  module Matcher
    class HaveAttributes < Base
      def match?
        expected.all? do |name, value|
          actual.send(name) == value
        end
      end

      def message
        "have attributes"
      end
    end
  end
end
