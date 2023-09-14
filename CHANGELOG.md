# Changelog

All notable changes to this project will be documented in this file.

## Head

- **Breaking** Change refinement to `extend` in an anonymous module. The usage should change as follows:
  ```diff
  -using Easytest::DSL
  +extend Easytest::DSL
  ```
- **Breaking** Drop support for Ruby 2.7 (End-of-Life on March 31, 2023)
- Remove extra whitespaces from console output.

## 0.9.0

- Add watch mode (`--watch`).
- Improve type coverage.

## 0.8.1

- Improve type-checking.

## 0.8.0

- Add `before` and `after` hooks.
- Add `to_have_attributes` matcher.
- Add `to_satisfy` matcher.

## 0.7.0

- Add `to_be_empty` matcher.
- Avoid unstable `Enumerable#sort_by` method.

## 0.6.0

- Add `to_contain_exactly` matcher.
- Allow `to_raise` to receive the second argument.

## 0.5.2

- Fix `homepage` in gemspec.

## 0.5.1

- Add RDoc to RBS.
- Publish the official website.

## 0.5.0

- **[Breaking]** Rename `to_not_raise` to `to_raise_nothing`.
- Add `to_match` matcher.
- Add `only` to run only any cases.

## 0.4.0

- Add `skip` and `test` without block for todo.
- Add `to_include` matcher.

## 0.3.1

- Remove polyfill from `.sig` file.

## 0.3.0

- Add RBS support.
- Add CLI help.
- Fix CLI to aware absolute paths.

## 0.2.0

- Add many matchers.

## 0.1.2

- Fix the `easytest` command exit code.

## 0.1.1

No code changes.

## 0.1.0

Initial release.
