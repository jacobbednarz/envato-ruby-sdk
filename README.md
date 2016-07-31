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

## Usage

First things first. Create an instance of the client which will be used by all
connections from here on out.

```rb
client = Envato::Client.new(access_token: 'mytops3crettoken')

# Send a 'GET' for the total number of users.
response = client.get 'market/total-users.json'
# => { :total-users" => { :total_users => "5942654" } }
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

## Using VCR

To ensure the test suite runs nice and fast we use VCR which generates our mocks
but using a real request that is stored inside of `spec/cassettes`. The way it
achieves this is it that each HTTP request is wrapped in a block which captures
the request, filters sensitive data and then stores it for the next person to
use. This means that not everyone needs to generate fresh requests and can
leverage known working responses.

As with all mocks, when the endpoint or functionality changes it is a good idea
to re-do them to ensure you are still testing against live endpoints. To do that
in this project, you'll need to run the following:

```
# Remove the existing files. You can be more specific here if you need to be.
$ rm -rf spec/cassettes/*

# Pass your REAL credentials in as environment variables and run the RSpec
# command.
$ ENVATO_TEST_API_TOKEN=thisisarealtoken \
  ENVATO_TEST_API_USERNAME=thisisarealuser \
  bundle exec rspec spec
```

It's super important you use real credentials when re-generating the cassettes
to ensure it is an accurate representation of the interactions. (Don't worry, we
don't commit your details to the cassettes they are filtered out by VCR!)

Note: Do not use the value of `ENVATO_TEST_API_USERNAME` in any of your tests
where it is passed into the URL. This will cause VCR not to create the cassette
due to the `ENVATO_TEST_API_USERNAME` being replaced during sanitisation.
## Releasing a new version

Everything you need to build a new release can be done by running:

```
$ script/release
```

This will handle pushing a new version of the gem to rubygems.org, a tag to
GitHub and updating the `master` branch.

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
