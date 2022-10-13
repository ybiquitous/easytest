module Easytest
  class Hook
    attr_reader :file
    attr_reader :type
    attr_reader :block

    def initialize(type:, &block)
      raise ArgumentError, "" unless [:before, :after].include?(type)

      @file = (caller_locations(3, 1)&.first&.absolute_path or raise)
      @type = type
      @block = block
    end

    def run(test_case)
      block.call(test_case)
    end

    def before?
      type == :before
    end

    def after?
      type == :after
    end
  end
end
