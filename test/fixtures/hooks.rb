require "easytest"
using Easytest::DSL

count = { before: 0, after: 0, names: [] }

before { count[:before] += 1 }
after { count[:after] += 1 }

test "first" do
  expect(count).to_eq({ before: 2, after: 0, names: ["before 'first'"] })
end

test "second" do
  expect(count).to_eq({ before: 4, after: 2, names: ["before 'first'", "after 'first'", "before 'second'"] })
  expect(1).to_eq 2 # fail on purpose
end

before do |c|
  count[:before] += 1
  count[:names] << "before '#{c.name}'"
end
after do |c|
  count[:after] += 1
  count[:names] << "after '#{c.name}'"
end
