module Easytest
  module DSL
    refine Kernel do
      def test(name, &block)
        file = caller_locations(2, 1).first.absolute_path
        Easytest.add_case Case.new(name: name, file: file, &block)
      end

      def expect(actual)
        Expectation.new(actual)
      end
    end
  end
end
