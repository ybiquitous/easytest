require "easytest"
require "optparse"

module Easytest
  class CLI
    SUCCESS = 0
    FAILURE = 1
    FATAL = 2

    def run
      exit_code = parse_argv
      return exit_code if exit_code

      if watch?
        watch_files
        return SUCCESS
      end

      Easytest.start
      setup
      successful = Easytest.run
      successful ? SUCCESS : FAILURE
    end

    private

    attr_reader :argv
    attr_reader :start_time
    attr_reader :options
    attr_reader :parser

    def initialize(argv)
      @argv = argv
      @start_time = Time.now
      @options = {}
      @parser = init_parser
    end

    def init_parser
      OptionParser.new do |op|
        op.program_name = "easytest"
        op.version = "#{op.program_name} #{Easytest::VERSION}"

        op.on "-w", "--watch" do
          options[:watch] = true
        end

        op.on "--help" do
          options[:help] = true
        end

        op.on "--version" do
          options[:version] = true
        end
      end
    end

    def parse_argv
      begin
        parser.parse!(argv)

        if options[:help]
          puts help
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

    def help
      program = Rainbow(parser.program_name).green
      heading = ->(text) { Rainbow(text).bright }
      secondary = ->(text) { Rainbow(text).dimgray }
      option = ->(text) { Rainbow(text).yellow }
      prompt = ->() { Rainbow("$").cyan }

      <<~MSG
        #{heading["USAGE"]}
          #{program} [options] [<file, directory, or pattern>...]

        #{heading["OPTIONS"]}
          #{option["-w, --watch"]}    Watch file changes and rerun test
          #{option["--help"]}         Show help
          #{option["--version"]}      Show version

        #{heading["EXAMPLES"]}
          #{secondary["# Run all tests (test/**/*_test.rb)"]}
          #{prompt[]} #{program}

          #{secondary["# Run only test files"]}
          #{prompt[]} #{program} test/example_test.rb

          #{secondary["# Run only test files in given directories"]}
          #{prompt[]} #{program} test/example

          #{secondary["# Run only test files that matches given patterns"]}
          #{prompt[]} #{program} example
      MSG
    end

    def setup
      test_files
        .filter do |file|
          argv.empty? || argv.any? { |pattern| file.include?(pattern) }
        end
        .each { load_test_file(_1) }
    end

    def load_test_file(file)
      load(file, true)
    end

    def test_files
      Dir.glob(Easytest.test_files_location).map do |file|
        File.absolute_path(file)
      end
    end

    def watch?
      options[:watch] == true
    end

    def watch_files
      require "listen"
      listener = Listen.to(Easytest.test_dir, only: /_test\.rb$/) do |modified, added|
        Easytest.start(no_tests_forbidden: false)
        test_files.intersection(modified + added).each { load_test_file(_1) }
        Easytest.run
      end
      listener.start

      begin
        puts "Start watching \"#{Easytest.test_files_location}\" changed. Press Ctrl-C to stop."
        sleep
      rescue Interrupt
        puts
        puts "Stopped watching."
      end
    end
  end
end
