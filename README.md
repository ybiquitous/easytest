# Easytest

> makes you write tests easily

## Features

*TODO*

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

Here is a very easy example.

First, put `test/addition_test.rb` as below:

```ruby
require "easytest"

using Easytest::DSL

test "addition" do
  expect(1 + 2).to_eq 2
end
```

Then, run `easytest`:

```console
$ bundle exec easytest
 FAIL  test/addition_test.rb
  ● addition  (should equal)

    Expected: 2
    Received: 3

    at test/addition_test.rb:6:in `block in <top (required)>'


 Tests:  1 failed, 0 passed, 1 total (1 files)
 Time:   0.00087 seconds
```

Oops. Let's fix the failure:

```diff
- expect(1 + 2).to_eq 2
+ expect(1 + 2).to_eq 3
```

Then, run it again:

```console
$ bundle exec easytest
 PASS  test/addition_test.rb

 Tests:  1 passed, 1 total (1 files)
 Time:   0.00077 seconds
```

The test passes! 🎉
