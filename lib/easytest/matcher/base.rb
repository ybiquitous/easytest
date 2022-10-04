module Easytest
  module Matcher
    class Base
      attr_reader :actual

      def initialize(actual:)
        @actual = actual
      end

      def match?
        raise NotImplementedError
      end

      def match!
        raise NotImplementedError
      end
    end
  end
end
