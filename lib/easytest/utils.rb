module Easytest
  module Utils
    module_function

    def terminal_hyperlink(absolute_path)
      path = Pathname(absolute_path)
      dir = path.relative_path_from(Dir.pwd).dirname.to_s + File::SEPARATOR
      base = path.basename

      # https://gist.github.com/egmontkob/eb114294efbcd5adb1944c9f3cb5feda
      "\e]8;;file://#{path}\e\\#{Rainbow(dir).dimgray}#{base}\e]8;;\e\\"
    end

    def raise_if_no_test_name(name, method:)
      if name.nil? || name.empty?
        raise FatalError.new("`#{method}` requires a name")
      end
    end

    def pluralize(singular, count)
      count == 1 ? singular : "#{singular}s"
    end

    def indent_text(text, indent_string)
      text.gsub(/^(.+)/, "#{indent_string}\\1")
    end

    def find_caller_file
      # Ruby 4.0 has a shorter call stack than 3.4, so we search for the first
      # caller location that's outside the easytest library itself
      lib_dir = File.expand_path("..", __dir__.to_s)
      caller_locations&.each do |loc|
        loc_path = loc.absolute_path
        return loc_path if loc_path && !loc_path.start_with?(lib_dir)
      end
      raise "Failed to find caller file in: #{caller_locations&.first || '<no callers>'}"
    end
  end
end
