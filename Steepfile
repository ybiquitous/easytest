target :test do
  signature "sig"

  check "test/smoke_test.rb"
end

target :lib do
  signature "sig"

  check "lib"
  library "pathname" # TODO: Remove this from from Ruby 3.2 because `pathname` has be out of a default gem.
end
