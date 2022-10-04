module Easytest
  class Reporter
    def initialize(error:, file:, location:)
      @error = error
      @file = file
      @location = location
    end

    def report(test_name)
      <<~MSG
        #{Rainbow("● #{test_name}").red.bright}

          #{Rainbow("Expected: #{@error.expected.inspect}").green}
          #{Rainbow("Received: #{@error.actual.inspect}").red}

          #{Rainbow("at #{@location}").dimgray}
      MSG
    end
  end
end
