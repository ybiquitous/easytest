module Easytest
  class Case
    attr_reader :name
    attr_reader :file
    attr_reader :block
    attr_accessor :report

    def initialize(name:, file:, &block)
      @name = name
      @file = file
      @block = block
      @report = nil
    end

    def run
      block.call
      true
    rescue UnmatchedError => error
      loc = error.backtrace_locations[2]
      self.report = Reporter.new(error: error, file: loc.absolute_path, location: loc.to_s).report(name)
      false
    end
  end
end
