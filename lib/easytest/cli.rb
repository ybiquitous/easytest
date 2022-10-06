require "easytest"

module Easytest
  class CLI
    SUCCESS = 0
    FAILURE = 1

    attr_reader :argv
    attr_reader :start_time

    def initialize(argv)
      @argv = argv
      @start_time = Time.now
    end

    def run
      Easytest.start
      setup
      successful = Easytest.run
      successful ? SUCCESS : FAILURE
    end

    private

    def setup
      Dir.glob(Easytest.test_files_location)
        .map { |file| File.absolute_path(file) }
        .filter do |file|
          argv.empty? || argv.any? { |pattern| file.include?(pattern) }
        end
        .each { |test_file| load test_file }
    end
  end
end
