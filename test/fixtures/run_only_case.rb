require "easytest"
extend Easytest::DSL

test "should not run this case" do
  raise
end

only "case 1" do
  # ...
end

only "case 2" do
  # ...
end

skip "skipped" do
  raise
end
