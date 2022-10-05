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
    rescue MatchError, FatalError => error
      loc = find_location(error) or raise

      self.report = Reporter.new(
        name: name,
        error: error,
        file: loc.absolute_path,
        location: loc.to_s,
      ).report or raise

      false
    end

    private

    def find_location(error)
      error.backtrace_locations.find { |loc| loc.path.end_with?("_test.rb") }
    end
  end
end
