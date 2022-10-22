module Easytest
  class Case
    attr_reader :name
    attr_reader :file
    attr_reader :block
    attr_reader :skipped
    attr_reader :only

    alias skipped? skipped
    alias only? only

    def initialize(name:, skipped: false, only: false, block: nil)
      @name = name
      @file = (caller_locations(3, 1)&.first&.absolute_path or raise)
      @block = block
      @skipped = skipped
      @only = only
    end

    def skip!
      @skipped = true
    end

    def run
      return [:todo, Reporter.new(name).report_todo] unless block
      return [:skipped, Reporter.new(name).report_skip] if skipped?

      block.call
      [:passed, nil]
    rescue MatchError, FatalError => error
      report = Reporter.new(name).report_error(error) or raise error
      [:failed, report]
    end
  end
end
