module Easytest
  class Runner
    attr_reader :start_time
    attr_accessor :passed_count
    attr_accessor :failed_count
    attr_accessor :skipped_count
    attr_accessor :todo_count
    attr_accessor :file_count

    def initialize(start_time: Time.now)
      @start_time = start_time
      @passed_count = 0
      @failed_count = 0
      @skipped_count = 0
      @todo_count = 0
      @file_count = 0
    end

    def run
      include_only_case = cases.any?(&:only?)
      hooks_by_file = hooks.group_by(&:file)

      cases.group_by(&:file).each do |file, cases_per_file|
        self.file_count += 1

        hooks = hooks_by_file.fetch(file, [])
        before_hooks = hooks.filter(&:before?)
        after_hooks = hooks.filter(&:after?)

        # @type var reports: Array[[Symbol, String]]
        reports = []

        cases_per_file.each do |c|
          if include_only_case && !c.only?
            c.skip!
          end

          result, report =
            begin
              before_hooks.each { |hook| hook.run(c) }
              c.run
            ensure
              after_hooks.each { |hook| hook.run(c) }
            end

          case result
          when :passed
            self.passed_count += 1
          when :failed
            self.failed_count += 1
          when :skipped
            self.skipped_count += 1
          when :todo
            self.todo_count += 1
          else
            raise "Unknown result: #{result.inspect}"
          end

          reports << [result, report] if report
        end

        link = Utils.terminal_hyperlink(file)

        if reports.none? { |result, _| result == :failed }
          puts "#{Rainbow(" PASS ").bright.bg(:green)} #{link}"
        else
          puts "#{Rainbow(" FAIL ").bright.bg(:red)} #{link}"
        end

        print_reports(reports)
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

    def hooks
      @hooks ||= []
    end

    def add_hook(hook)
      hooks << hook
    end

    private

    def total_count
      passed_count + failed_count + skipped_count + todo_count
    end

    def all_passed?
      failed_count == 0
    end

    def no_tests?
      total_count == 0
    end

    def print_reports(reports)
      unexecuted = [:skipped, :todo]
      indent = "  "

      reports.each do |result, report|
        puts Utils.indent_text(report, indent) if unexecuted.include?(result)
      end

      reports.each do |result, report|
        puts Utils.indent_text(report, indent) unless unexecuted.include?(result)
        puts "" if result == :failed
      end
    end

    def elapsed_time
      Time.now - start_time
    end

    def summary
      # @type var list: Array[String]
      list = []

      if failed_count > 0
        list << Rainbow("#{failed_count} failed").red.bright
      end

      if skipped_count > 0
        list << Rainbow("#{skipped_count} skipped").yellow.bright
      end

      if todo_count > 0
        list << Rainbow("#{todo_count} todo").magenta.bright
      end

      list << Rainbow("#{passed_count} passed").green.bright

      files_text = "#{file_count} #{Utils.pluralize("file", file_count)}"
      list << "#{total_count} total #{Rainbow("(#{files_text})").dimgray}"

      list.join(", ")
    end
  end
end
