module Easytest
  module DSL
    refine Kernel do
      def test(name, &block)
        Utils.raise_if_no_test_name(name, method: "test")

        file = caller_locations(1, 1).first.absolute_path
        Easytest.add_case Case.new(name: name, file: file, &block)
      end

      def skip(name, &block)
        Utils.raise_if_no_test_name(name, method: "skip")

        file = caller_locations(1, 1).first.absolute_path
        Easytest.add_case Case.new(name: name, file: file, skipped: true, &block)
      end

      def only(name, &block)
        Utils.raise_if_no_test_name(name, method: "only")

        file = caller_locations(1, 1).first.absolute_path
        Easytest.add_case Case.new(name: name, file: file, only: true, &block)
      end

      def expect(actual = nil, &block)
        Expectation.new(actual, &block)
      end
    end
  end
end
