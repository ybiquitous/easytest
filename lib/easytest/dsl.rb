module Easytest
  module DSL
    refine Kernel do
      def test(name, &block)
        raise FatalError, "`test` requires a name" if name.nil? || name.empty?

        file = caller_locations(1, 1).first.absolute_path
        Easytest.add_case Case.new(name: name, file: file, &block)
      end

      def skip(name, &block)
        raise FatalError, "`skip` requires a name" if name.nil? || name.empty?

        file = caller_locations(1, 1).first.absolute_path
        Easytest.add_case Case.new(name: name, file: file, skipped: true, &block)
      end

      def expect(actual = nil, &block)
        Expectation.new(actual, &block)
      end
    end
  end
end
