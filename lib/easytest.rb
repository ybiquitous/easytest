require "pathname"
require "rainbow"

require_relative "easytest/version"

require_relative "easytest/case"
require_relative "easytest/dsl"
require_relative "easytest/errors"
require_relative "easytest/expectation"
require_relative "easytest/hook"
require_relative "easytest/reporter"
require_relative "easytest/runner"
require_relative "easytest/utils"

# Matcher
require_relative "easytest/matcher/base"
require_relative "easytest/matcher/be"
require_relative "easytest/matcher/be_a"
require_relative "easytest/matcher/contain_exactly"
require_relative "easytest/matcher/empty"
require_relative "easytest/matcher/equal"
require_relative "easytest/matcher/false"
require_relative "easytest/matcher/have_attributes"
require_relative "easytest/matcher/include"
require_relative "easytest/matcher/instance_of"
require_relative "easytest/matcher/kind_of"
require_relative "easytest/matcher/match"
require_relative "easytest/matcher/nil"
require_relative "easytest/matcher/raise"
require_relative "easytest/matcher/raise_nothing"
require_relative "easytest/matcher/satisfy"
require_relative "easytest/matcher/true"

module Easytest
  def self.start(no_tests_forbidden: true)
    @runner = Runner.new(no_tests_forbidden: no_tests_forbidden)
  end

  def self.add_case(new_case)
    @runner.add_case(new_case)
  end

  def self.add_hook(hook)
    @runner.add_hook(hook)
  end

  def self.run
    @runner.run
  end

  def self.test_dir
    "test"
  end

  def self.test_files_location
    "#{test_dir}/**/*_test.rb"
  end
end
