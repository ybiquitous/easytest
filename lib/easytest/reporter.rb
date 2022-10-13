module Easytest
  class Reporter
    attr_reader :name

    def initialize(name)
      @name = name
    end

    def report_error(error)
      case error
      when MatchError
        report_match_error(error)
      when FatalError
        report_fatal_error(error)
      end
    end

    def report_skip
      Rainbow("⚠ skipped \"#{name}\"").yellow
    end

    def report_todo
      Rainbow("✎ todo \"#{name}\"").magenta
    end

    private

    def report_match_error(error)
      loc = find_location(error)

      <<~MSG
        #{Rainbow("✕ #{name}").red.bright}  #{Rainbow("(#{error.message})").dimgray}

          #{Rainbow("Expected: #{error.expected.inspect}").green}
          #{Rainbow("Received: #{error.actual.inspect}").red}

          #{Rainbow(format_location(loc)).dimgray}
      MSG
    end

    def report_fatal_error(error)
      loc = find_location(error)

      <<~MSG
        #{Rainbow("✕ #{name}").red.bright}

          #{Rainbow(error.message).red}

          #{Rainbow(format_location(loc)).dimgray}
      MSG
    end

    def find_location(error)
      location = error.backtrace_locations&.find do |loc|
        loc.path&.end_with?("_test.rb")
      end
      location or raise "Not found test location from #{error.inspect}"
    end

    def format_location(location)
      absolute_path = location.absolute_path or raise
      path = Pathname(absolute_path).relative_path_from(Dir.pwd)
      "# #{path}:#{location.lineno}:in `#{location.label}'"
    end
  end
end
