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
# => {"total-users"=>{"total_users"=>"5942654"}}
```

## Examples

Here is a list of the functionality available via this gem. All examples expect
that you have already created a client called `client` as seen in the above
example. `...` represents multiple of the previous item repeated such as a hash
or array item.

#### Catalog

- [`get_public_collection`](https://build.envato.com/api/#market_0_Catalog_Collection)

  ```rb
  client.get_public_collection(5507368)
  # => {"id"=>5507368, "name"=>"Test public collection", "description"=>"This is an example public collection", "private"=>false, "item_count"=>1, "image"=>"default-collection.png"}
  ```

- [`get_item`](https://build.envato.com/api/#market_0_Catalog_Item)

  ```rb
  client.get_item(14157442)
  # => {"id"=>14157442, "name"=>"Beautiful Watercolor - Hand Painted Creative WordPress", "description"=>"<p><img src=\"http://dtbaker.net/wp-content/uploads/sites ...
  ```

#### User

- [`account_details`](https://build.envato.com/api/#market_Account)

  ```rb
  client.account_details
  # => {"image"=>"https://0.s3.envato.com/files/144155428/avatar.jpg", "firstname"=>"Jacob", "surname"=>"Bednarz", "available_earnings"=>"0.00", "total_deposits"=>"0.00", "balance"=>"0.00", "country"=>"Australia"}
  ```

- [`username`](https://build.envato.com/api/#market_Username)

  ```rb
  client.username
  # => 'jacobbednarz'
  ```

- [`email_address`](https://build.envato.com/api/#market_Email)

  ```rb
  client.email_address
  # => 'jacob@envato.com'
  ```

- [`user_information`](https://build.envato.com/api/#market_User)

  ```rb
  client.user_information('jacobbednarz')
  # => {"username": "jacobbednarz","country": "Australia","sales": "0","location": "","image": "https://0.s3.envato.com/files/144155428/avatar.jpg","followers": "4"}
  ```

- [`badges_for_user`](https://build.envato.com/api/#market_UserBadges)

  ```rb
  client.badges_for_user('jacobbednarz')
  # => [{"name"=>"country_au", "label"=>"Australia", "image"=>"https://dmypbau5frl9g.cloudfront.net/assets/badges/country_au-53dc340a932f5b9f1d1db574fb6712b4.svg"}, {"name"=>"envato_team", "label"=>"Envato Team", "image"=>"https://dmypbau5frl9g.cloudfront.net/assets/badges/envato_team-ac987db51c92549046fa25dfb7259bf9.svg"}, {"name"=>"exclusive", "label"=>"Exclusive Author", "image"=>"https://dmypbau5frl9g.cloudfront.net/assets/badges/exclusive-f7d9bbcda891f9ad25f00da4ea099435.svg"}]
  ```

- [`user_items_by_site`](https://build.envato.com/api/#market_UserItemsBySite)

  ```rb
  client.user_items_by_site('collis')
  # => [{"site"=>"ThemeForest", "items"=>"1"}, {"site"=>"Tuts+ Marketplace", "items"=>"2"}]
  ```

- [`new_items_for_user`](https://build.envato.com/api/#market_NewFilesFromUser)

  ```rb
  client.new_items_for_user('collis', 'themeforest')
  # => [{"id"=>"22705", "item"=>"Black + White Simple Theme", "url"=>"http://themeforest.net/item/black-white-simple-theme/22705", "user"=>"collis", "thumbnail"=>"https://preview-tf.s3.envato.com/files/60223.jpg", "sales"=>"916", "rating"=>"4.5", "rating_decimal"=>"4.32", "cost"=>"8.00", "uploaded_on"=>"Tue Dec 02 04:01:12 +1100 2008", "last_update"=>"", "tags"=>"clean", "category"=>"psd-templates/creative", "live_preview_url"=>"https://0.s3.envato.com/files/60224/1_home.__large_preview.jpg"}]
  ```

#### Marketplace Stats

- [`total_items`](https://build.envato.com/api/#market_TotalItems)

  ```rb
  client.total_items
  # => 12345
  ```

- [`total_users`](https://build.envato.com/api/#market_TotalUsers)

  ```rb
  client.total_users
  # => 23456
  ```

- [`category_information_by_site`](https://build.envato.com/api/#market_NumberOfFiles)

  ```rb
  client.category_information_by_site('themeforest')
  # => [{"category"=>"Site Templates","number_of_files"=>"6551","url"=>"http://themeforest.net/category/site-templates"}, ... ]
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
