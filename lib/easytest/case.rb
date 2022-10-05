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
    rescue MatchError => error
      location = error.backtrace_locations.find { |loc| loc.path.end_with?("_test.rb") } or raise
      self.report = Reporter.new(error: error, file: location.absolute_path, location: location.to_s).report(name)
      false
    end
  end
end
