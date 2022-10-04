# Easytest

> makes you write tests easily

## Installation

Via Bundler:

```shell
bundle add easytest
```

Via gem:

```shell
gem install easytest
```

## Usage

Put `test/example_test.rb` including the content:

```ruby
require "easytest"

using Easytest::DSL

test "simple addition" do
  expect(1 + 1).to_eq 2
end

test "even number" do
  expect(2.even?).to_be true
  expect(1.even?).to_be false
end
```

Then, run `easytest`:

```console
$ bundle exec easytest
 PASS  test/example_test.rb

 Tests:  2 passed, 2 total (1 files)
 Time:   0.00091 seconds
```
