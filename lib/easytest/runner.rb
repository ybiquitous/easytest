module Easytest
  class Runner
    attr_reader :start_time
    attr_accessor :passed_count
    attr_accessor :failed_count
    attr_accessor :file_count

    def initialize(start_time: Time.now)
      @start_time = start_time
      @passed_count = 0
      @failed_count = 0
      @file_count = 0
    end

    def run
      cases_by_file = cases.group_by { |c| c.file }
      cases_by_file.each do |file, cases|
        self.file_count += 1
        reports = []

        cases.each do |c|
          passed = c.run

          if passed
            self.passed_count += 1
          else
            self.failed_count += 1
            reports << c.report.gsub(/^/, "  ")
          end
        end

        link = Utils.terminal_hyperlink(file)
        if reports.empty?
          puts "#{Rainbow(" PASS ").bright.bg(:green)} #{link}"
        else
          puts "#{Rainbow(" FAIL ").bright.bg(:red)} #{link}"
          reports.each { |report| puts report ; puts "" }
        end
      end

      if no_tests?
        $stderr.puts <<~MSG
          #{Rainbow("Oops. No tests found!").red.bright}

          #{Rainbow("Put `#{Easytest.test_files_location}` files to include at least one test case.").red}
          #{Rainbow("Or specify a pattern that matches an existing test file.").red}
        MSG
        false
      else
        puts ""
        puts " #{Rainbow('Tests:').bright}  #{summary}"
        puts " #{Rainbow('Time:').bright}   #{elapsed_time.round(5)} seconds"
        all_passed?
      end
    end

    def cases
      @cases ||= []
    end

    def add_case(new_case)
      cases << new_case
    end

    private

    def total_count
      passed_count + failed_count
    end

    def all_passed?
      failed_count == 0
    end

    def no_tests?
      total_count == 0
    end

    def elapsed_time
      Time.now - start_time
    end

    def summary
      summary = ""

      if failed_count == 0
        summary << Rainbow("#{passed_count} passed").green.bright
      else
        summary << Rainbow("#{failed_count} failed").red.bright
        summary << ", #{Rainbow("#{passed_count} passed").green.bright}"
      end

      summary << ", #{total_count} total #{Rainbow("(#{file_count} files)").dimgray}"
    end
  end
end
