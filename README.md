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

- [`popular_items_by_site`](https://build.envato.com/api/#market_Popular)

  ```rb
  client.popular_items_by_site('themeforest')
  # => {"items_last_week"=>[{"id"=>"2833226", "item"=>"Avada | Responsive Multi-Purpose Theme", "url"=>"http://themeforest.net/item/avada-responsive-multipurpose-theme/2833226", "user"=>"ThemeFusion", "thumbnail"=>"https://0.s3.envato.com/files/169508862/Thumbnail.jpg", "sales"=>"1939", "rating"=>"5.0", "rating_decimal"=>"4.78", "cost"=>"59.00", "uploaded_on"=>"Thu Aug 16 01:28:46 +1000 2012", "last_update"=>"Thu Jan 28 12:13:49 +1100 2016", "tags"=>"blog, business, clean, corporate, creative, ecommerce, modern, multipurpose, one page, photography, portfolio, responsive, retina, woocommerce, wordpress", "category"=>"wordpress/corporate", "live_preview_url"=>"https://0.s3.envato.com/files/169508866/screenshots/00_preview.__large_preview.jpg"}, {"id"=>"5871901", "item"=>"X | The Theme", ...
  ```

- [`categories_by_site`](https://build.envato.com/api/#market_Categories)

  ```rb
  client.categories_by_site('themeforest')
  # => [{"name"=>"Site Templates", "path"=>"site-templates"}, {"name"=>"Creative", "path"=>"site-templates/creative"}, {"name"=>"Portfolio", "path"=>"site-templates/creative/portfolio"}, {"name"=>"Photography", "path"=>"site-templates/creative/photography"}, {"name"=>"Art", "path"=>"site-templates/creative/art"}, {"name"=>"Experimental", "path"=>"site-templates/creative/experimental"} ...]
  ```

- [`prices_for_item`](https://build.envato.com/api/#market_ItemPrices)

  ```rb
  client.prices_for_item(13582227)
  # => [{"licence"=>"Regular License", "price"=>"24.00"}, {"licence"=>"Extended License", "price"=>"1200.00"}]
  ```

- [`featured_by_site`](https://build.envato.com/api/#market_Features)

  ```rb
  client.featured_by_site('themeforest')
  # => {"featured_file"=>{"id"=>"14631264", "item"=>"Luxury - Responsive Virtuemart Theme", "url"=>"http://themeforest.net/item/luxury-responsive-virtuemart-theme/14631264", "user"=>"dasinfomedia", "thumbnail"=>"https://0.s3.envato.com/files/169212120/luxury_thumb_jml.png", "sales"=>"27", "rating"=>"0.0", "rating_decimal"=>"0.00", "cost"=>"48.00", "uploaded_on"=>"Wed Feb 03 04:32:39 +1100 2016", "last_update"=>"Wed Mar 23 01:40:20 +1100 2016", "tags"=>"clean, clear shop, clothing, creative design, fashion, home furniture, joomla 3 theme, lifestyle, modern, online shop, professional joomla template", "category"=>"cms-themes/joomla/retail/fashion", "live_preview_url"=>"https://0.s3.envato.com/files/169212284/01_preview.__large_preview.png"}, "featured_author"=>{"id"=>"2016597", "user"=>"DigitalAtelier", "url"=>"http://themeforest.net/user/digitalatelier", "thumbnail"=>"https://0.s3.envato.com/files/50767715/logo.png"}, "free_file"=>{"id"=>"11403244", "item"=>"Melica – Responsive WordPress Blog Theme", "url"=>"http://themeforest.net/item/melica-responsive-wordpress-blog-theme/11403244", "user"=>"wphunters", "thumbnail"=>"https://0.s3.envato.com/files/174945675/thumbnail.png", "sales"=>"52", "rating"=>"5.0", "rating_decimal"=>"5.00", "cost"=>"44.00", "uploaded_on"=>"Fri May 22 05:00:32 +1000 2015", "last_update"=>"Wed Mar 02 00:53:28 +1100 2016", "tags"=>"blog, blogger, clean, creative, fashion, food, instagram, minimal, modern, music, personal,slider, travel, video", "category"=>"wordpress/blog-magazine/personal", "live_preview_url"=>"https://0.s3.envato.com/files/174945678/preview_wp.__large_preview.jpg"}}
  ```

- [`random_new_items_by_site`](https://build.envato.com/api/#market_RandomNewFiles)

  ```rb
  client.random_new_items_by_site('themeforest')
  # => [{"id"=>"15345030", "item"=>"Legal justice - HTML Template", "url"=>"http://themeforest.net/item/legal-justice-html-template/15345030", "user"=>"Xstyler", "thumbnail"=>"https://0.s3.envato.com/files/176988930/Thumbnail.png", "sales"=>"0", "rating"=>"0.0", "rating_decimal"=>"0.00", "cost"=>"15.00"}, {"id"=>"15346859", "item"=>"Gear — Automotive Business/Auto Parts Store PSD Template", "url"=>"http://themeforest.net/item/gear-automotive-businessauto-parts-store-psd-template/15346859", "user"=>"torbara", "thumbnail"=>"https://0.s3.envato.com/files/177009058/Gear_Icon.png", "sales"=>"0", "rating"=>"0.0", "rating_decimal"=>"0.00", "cost"=>"12.00"}, {"id"=>"15343695", "item"=>"Noren - Multi Store Responsive HTML Template","url"=>"http://themeforest.net/item/noren-multi-store-responsive-html-template/15343695", "user"=>"EngoTheme", "thumbnail"=>"https://0.s3.envato.com/files/178795450/80x80.jpg", "sales"=>"0", "rating"=>"0.0", "rating_decimal"=>"0.00", "cost"=>"17.00"}, {"id"=>"14770935", "item"=>"Outlaw - Stylish WooCommerce WordPress Theme", "url"=>"http://themeforest.net/item/outlaw-stylish-woocommerce-wordpress-theme/14770935", "user"=>"elusivethemes", "thumbnail"=>"https://0.s3.envato.com/files/178441822/thumb.jpg", "sales"=>"0", "rating"=>"0.0", "rating_decimal"=>"0.00", "cost"=>"59.00"}, {"id"=>"15101532", "item"=>"Ri Quartz - Responsive Multipurpose WooCommerce Theme", "url"=>"http://themeforest.net/item/ri-quartz-responsive-multipurpose-woocommerce-theme/15101532", "user"=>"CleverSoft", "thumbnail"=>"https://0.s3.envato.com/files/174287786/quartz.jpg", "sales"=>"1", "rating"=>"0.0", "rating_decimal"=>"0.00", "cost"=>"59.00"}, {"id"=>"15332367", "item"=>"Highstand - Responsive MultiPurpose HTML5 Template ", "url"=>"http://themeforest.net/item/highstand-responsive-multipurpose-html5-template-/15332367", "user"=>"gsrthemes9", "thumbnail"=>"https://0.s3.envato.com/files/178795406/thumb.jpg", "sales"=>"1", "rating"=>"0.0", "rating_decimal"=>"0.00", "cost"=>"17.00"}, {"id"=>"15156133", "item"=>"James - Responsive WooCommerce Shoes Theme", "url"=>"http://themeforest.net/item/james-responsive-woocommerce-shoes-theme/15156133", "user"=>"roadthemes", "thumbnail"=>"https://0.s3.envato.com/files/178879482/thumbnail.png", "sales"=>"0", "rating"=>"0.0", "rating_decimal"=>"0.00", "cost"=>"59.00"}, {"id"=>"15319096", "item"=>"Mozar - Fashion Clothing Bootstrap Template", "url"=>"http://themeforest.net/item/mozar-fashion-clothing-bootstrap-template/15319096", "user"=>"BootExperts", "thumbnail"=>"https://0.s3.envato.com/files/176721976/thumbnail.png", "sales"=>"0", "rating"=>"0.0", "rating_decimal"=>"0.00", "cost"=>"17.00"}, {"id"=>"14752612", "item"=>"Hash - Responsive WordPress Magazine Theme", "url"=>"http://themeforest.net/item/hash-responsive-wordpress-magazine-theme/14752612", "user"=>"PremiumLayers", "thumbnail"=>"https://0.s3.envato.com/files/178438623/80x80.jpg", "sales"=>"0", "rating"=>"0.0", "rating_decimal"=>"0.00", "cost"=>"49.00"}, {"id"=>"15079135", "item"=>"BlueMed - Health and Medical WordPress Theme", "url"=>"http://themeforest.net/item/bluemed-health-and-medical-wordpress-theme/15079135", "user"=>"happy_robot", "thumbnail"=>"https://0.s3.envato.com/files/178384359/icon.png", "sales"=>"1", "rating"=>"0.0", "rating_decimal"=>"0.00", "cost"=>"49.00"}]
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
  # => {"username"=>"jacobbednarz", "country"=>"Australia", "sales"=>"0", "location"=>"", "image" => "https://0.s3.envato.com/files/144155428/avatar.jpg", "followers"=>"4"}
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

- [`sales_per_month`](https://build.envato.com/api/#market_EarningsAndSalesByMonth)

  ```rb
  client.sales_per_month
  # => [{"month"=>"Mon Jun 01 00:00:00 +1000 2009", "sales"=>"10", "earnings"=>"120.60"} ... ]
  ```

- [`user_statement`](https://build.envato.com/api/#market_Statement)

  ```rb
  client.user_statement
  # => [{"kind"=>"Author Fee", "amount"=>"-1.00", "description"=>"Author Fee for included support sale IVIP1234", "occured_at"=>"Sat Apr 09 05:11:49 +1000 2014"} ... ]
  ```

- [`sales`](https://build.envato.com/api/#market_0_Author_Sales)

  ```rb
  client.sales
  # => [{"amount"=>"20.00", "sold_at"=>"2016-04-09T05:19:48+10:00", "item"=>{"id"=>123456, "name"=>"A cool theme - WordPress","description"=>"This is a theme I made and looks good!", "summary"=>"Widget Ready: Yes" ... ]
  ```

- [`sale_by_purchase_code`](https://build.envato.com/api/#market_0_Author_Sale)

  ```rb
  client.sale_by_purchase_code('1234-5678')
  # => {"amount" => "5.40", "sold_at" => "2009-11-13T19:28:25+11:00", "item" => {"id":1234, "name":"Test theme - HTML","description":"Test description" ... }
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
