require "pathname"
require "rainbow"

require_relative "easytest/version"

require_relative "easytest/case"
require_relative "easytest/cli"
require_relative "easytest/dsl"
require_relative "easytest/errors"
require_relative "easytest/expectation"
require_relative "easytest/matcher/base"
require_relative "easytest/matcher/be"
require_relative "easytest/matcher/be_nil"
require_relative "easytest/matcher/equal"
require_relative "easytest/reporter"
require_relative "easytest/runner"
require_relative "easytest/utils"

module Easytest
  def self.start
    @runner = Runner.new
  end

  def self.add_case(new_case)
    @runner.cases << new_case
  end

  def self.run
    @runner.run
  end

  def self.test_files_location
    "test/**/*_test.rb"
  end
end
