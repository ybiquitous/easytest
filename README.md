[![Gem Version](https://badge.fury.io/rb/easytest.svg)](https://badge.fury.io/rb/easytest)
[![CI](https://github.com/ybiquitous/easytest/actions/workflows/ci.yml/badge.svg)](https://github.com/ybiquitous/easytest/actions/workflows/ci.yml)

# Easytest

> makes you write tests easily

Easytest is a tiny testing framework for Ruby with a familiar DSL.

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
$ easytest
 FAIL  test/addition_test.rb
  ✕ addition  (should equal)

    Expected: 2
    Received: 3

    # test/addition_test.rb:6:in `block in <top (required)>'


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
$ easytest
 PASS  test/addition_test.rb

 Tests:  1 passed, 1 total (1 files)
 Time:   0.00077 seconds
```

The test now passes! 🎉

### Skip

If you want to skip any cases, you can change `test` to `skip`:

```ruby
-test "addition" do
+skip "addition" do
   expect(1 + 2).to_eq 2
 end
```

### To-do

If you want to write to-dos for cases, you can use `test` without a block:

```ruby
test "#foo method"
test "#bar method"
test "#baz method"
# ...
```
