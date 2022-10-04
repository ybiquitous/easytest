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
  end
end
