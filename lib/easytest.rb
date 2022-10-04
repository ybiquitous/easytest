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
  def self.run!
    cases_by_file = cases.group_by { |c| c.file }
    cases_by_file.each do |file, cases|
      puts "#{Rainbow(" FAIL ").bright.bg(:red)} #{Utils.terminal_hyperlink(file)}"

      cases.each do |c|
        c.run
        puts c.report.gsub(/^/, "  ")
        puts
      end
    end
  end

  def self.cases
    @cases ||= []
  end

  def self.add_case(new_case)
    cases << new_case
  end
end

at_exit do
  Easytest.run!
end
