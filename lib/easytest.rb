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

    puts "#{Rainbow('Summary:').bright} #{Rainbow("#{failed_count} failed").red.bright}, " \
         "#{Rainbow("#{passed_count} passed").green.bright}, " \
         "#{passed_count + failed_count} total"
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
  Easytest.run

  time = Time.now - start_time

  puts "#{Rainbow('Time:').bright}    #{time.round(5)} seconds"
end
