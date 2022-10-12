module Easytest
  module DSL
    refine Kernel do
      def test(name, &block)
        Utils.raise_if_no_test_name(name, method: "test")
        Easytest.add_case Case.new(name: name, &block)
      end

      def before(&block)
        Easytest.add_hook Hook.new(type: :before, &block)
      end

      def after(&block)
        Easytest.add_hook Hook.new(type: :after, &block)
      end

      def skip(name, &block)
        Utils.raise_if_no_test_name(name, method: "skip")
        Easytest.add_case Case.new(name: name, skipped: true, &block)
      end

      def only(name, &block)
        Utils.raise_if_no_test_name(name, method: "only")
        Easytest.add_case Case.new(name: name, only: true, &block)
      end

      def expect(actual = nil, &block)
        Expectation.new(actual, &block)
      end
    end
  end
end
