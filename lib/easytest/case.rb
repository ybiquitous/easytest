module Easytest
  class Case
    attr_reader :name
    attr_reader :file
    attr_reader :block
    attr_reader :skipped
    alias skipped? skipped

    def initialize(name:, file:, skipped: false, &block)
      @name = name
      @file = file
      @block = block
      @skipped = skipped
    end

    def todo?
      block.nil?
    end

    def run
      if todo?
        return [:todo, Reporter.new(name).report_todo]
      end

      if skipped?
        return [:skipped, Reporter.new(name).report_skip]
      end

      block.call
      [:passed, nil]
    rescue MatchError, FatalError => error
      report = Reporter.new(name).report_error(error) or raise error
      [:failed, report]
    end
  end
end
