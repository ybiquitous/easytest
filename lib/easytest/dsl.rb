module Easytest
  module DSL
    def test(name, &block)
      Utils.raise_if_no_test_name(name, method: "test")
      Easytest.add_case Case.new(name: name, block: block)
    end

    def before(&block)
      Easytest.add_hook Hook.new(type: :before, block: block)
    end

    def after(&block)
      Easytest.add_hook Hook.new(type: :after, block: block)
    end

    def skip(name, &block)
      Utils.raise_if_no_test_name(name, method: "skip")
      Easytest.add_case Case.new(name: name, skipped: true, block: block)
    end

    def only(name, &block)
      Utils.raise_if_no_test_name(name, method: "only")
      Easytest.add_case Case.new(name: name, only: true, block: block)
    end

    def expect(actual = nil, &)
      Expectation.new(actual, &)
    end
  end
end
