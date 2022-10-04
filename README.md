# Easytest

> makes you write tests easily

## Installation

via Bundler:

```shell
bundle add easytest
```

via gem:

```shell
gem install easytest
```

## Usage

First, put `test/example_test.rb` including the content below:

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

You should see all tests pass.

Now let's add a failed case as below:

```ruby
test "nil" do
  expect("foo").to_be_nil
end
```

And then, run it again:

```console
$ bundle exec easytest
 FAIL  test/example_test.rb
  ● nil  (should be `nil`)

    Expected: nil
    Received: "foo"

    at test/example_test.rb:15:in `block in <top (required)>'


 Tests:  1 failed, 2 passed, 3 total (1 files)
 Time:   0.00095 seconds
```

You should see the failure report this time.
