module Easytest
  class Reporter
    attr_reader :name
    attr_reader :error
    attr_reader :file
    attr_reader :location

    def initialize(name:, error:, file:, location:)
      @name = name
      @error = error
      @file = file
      @location = location
    end

    def report
      case error
      when MatchError
        report_match_error
      when FatalError
        report_fatal_error
      end
    end

    private

    def report_match_error
      <<~MSG
        #{Rainbow("● #{name}").red.bright}  #{Rainbow("(#{error.message})").dimgray}

          #{Rainbow("Expected: #{error.expected.inspect}").green}
          #{Rainbow("Received: #{error.actual.inspect}").red}

          #{Rainbow("# #{location}").dimgray}
      MSG
    end

    def report_fatal_error
      <<~MSG
        #{Rainbow("● #{name}").red.bright}

          #{Rainbow(error.message).red}

          #{Rainbow("# #{location}").dimgray}
      MSG
    end
  end
end
