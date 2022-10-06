require "easytest"
require "optparse"

module Easytest
  class CLI
    SUCCESS = 0
    FAILURE = 1
    FATAL = 2

    def run
      exit_code = parse_options
      return exit_code if exit_code

      Easytest.start
      setup
      successful = Easytest.run
      successful ? SUCCESS : FAILURE
    end

    private

    attr_reader :argv
    attr_reader :start_time

    def initialize(argv)
      @argv = argv
      @start_time = Time.now
    end

    def parse_options
      options = {}

      parser = OptionParser.new do |p|
        p.program_name = "easytest"
        p.version = "#{p.program_name} #{Easytest::VERSION}"

        p.on "--help" do
          options[:help] = true
        end

        p.on "--version" do
          options[:version] = true
        end
      end

      begin
        parser.parse!(argv)

        if options[:help]
          puts help(parser)
          return SUCCESS
        end

        if options[:version]
          puts parser.version
          return SUCCESS
        end

        nil
      rescue OptionParser::ParseError => error
        $stderr.puts Rainbow(error.message).red
        FATAL
      end
    end

    def help(parser)
      <<~MSG
        #{Rainbow("USAGE").bright}
          #{parser.program_name} [options] [...<file, directory, or pattern>]

        #{Rainbow("OPTIONS").bright}
          --help      Show help
          --version   Show version
      MSG
    end

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
