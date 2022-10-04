require "pathname"
require "rainbow"

require_relative "easytest/version"

require_relative "easytest/case"
require_relative "easytest/dsl"
require_relative "easytest/errors"
require_relative "easytest/expectation"
require_relative "easytest/matcher/base"
require_relative "easytest/matcher/be_nil"
require_relative "easytest/matcher/equal"
require_relative "easytest/reporter"
require_relative "easytest/utils"

module Easytest
  def self.run
    passed_count = 0
    failed_count = 0

    cases_by_file = cases.group_by { |c| c.file }
    cases_by_file.each do |file, cases|
      puts "#{Rainbow(" FAIL ").bright.bg(:red)} #{Utils.terminal_hyperlink(file)}"

      cases.each do |c|
        passed = c.run

        if passed
          passed_count += 1
        else
          failed_count += 1
          puts c.report.gsub(/^/, "  ")
          puts ""
        end
      end
    end

    [passed_count, failed_count]
  end

  def self.cases
    @cases ||= []
  end

  def self.add_case(new_case)
    cases << new_case
  end
end

start_time = Time.now

at_exit do
  passed_count, failed_count = Easytest.run
  total_count = passed_count + failed_count

  time = Time.now - start_time

  if total_count == 0
    puts Rainbow("A test suite should have at least one test case!").red.bright
    puts ""
    puts "Please put `test/**/*_test.rb` files or specify valid patterns to the `easytest` command."
  else
    puts "#{Rainbow('Summary:').bright} #{Rainbow("#{failed_count} failed").red.bright}, " \
         "#{Rainbow("#{passed_count} passed").green.bright}, #{total_count} total"
    puts "#{Rainbow('Time:').bright}    #{time.round(5)} seconds"
  end
end
