module Easytest
  class Error < StandardError; end

  class UnmatchedError < Error
    attr_reader :actual
    attr_reader :expected

    def initialize(message:, actual:, expected:)
      super(message)
      @actual = actual
      @expected = expected
    end
  end
end
