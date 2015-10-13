# Envato Ruby SDK [![Build Status](https://travis-ci.org/jacobbednarz/envato-ruby-sdk.svg?branch=master)](https://travis-ci.org/jacobbednarz/envato-ruby-sdk)

Interact with the [Envato API][envato_api_url] using Ruby.

## Installation

Quickstart

```
$ gem install envato-sdk
```

Or using a Gemfile:

```
$ gem 'envato-sdk'
```

## Testing

RSpec is the testing tool of choice and you can kick off the test suite by
running:

```
$ bundle exec rspec spec
```

The following Ruby versions are supported (and [tested against][travis_ci_url]):

- Ruby 2.0
- Ruby 2.1
- Ruby 2.2

## Contributing

Contributions are welcome (in fact, encouraged!) to this project. To ensure
everything continues humming along nicely, there are a few guidelines.

- All code changes **must** add tests for the functionality. Without tests
  someone may accidently break your changes and cause regressions.
- If looking to add a large piece of new functionality,
  [open an issue][new_issue_url] first and get some feedback on whether it's
  something the maintainers are willing to accept. We don't want anyone wasting
  time on changes only to be told the project won't accept them.

[envato_api_url]: https://build.envato.com
[travis_ci_url]: https://travis-ci.org/jacobbednarz/envato-ruby-sdk
[new_issue_url]: https://github.com/jacobbednarz/envato-ruby-sdk/issues/new
