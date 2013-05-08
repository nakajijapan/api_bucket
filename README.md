# ApiBucket

[![Gem Version](https://badge.fury.io/rb/api_bucket.png)](http://badge.fury.io/rb/api_bucket)

We can use sevral APIs with common interface.


* APIs
  * Amazon ECS
  * iTunes
  * Rakuten(楽天)
  * Yahoo Auction

## Installation

Add this line to your application's Gemfile:

    gem 'api_bucket'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install api_bucket

## Usage

### use Amazon

```ruby
require 'api_bucket'
require 'api_bucket/amazon'

ApiBucket::Amazon.configure do |o|
    o.a_w_s_access_key_id = 'hogehoge'
    o.a_w_s_secret_key    = 'mogemoge'
    o.associate_tag       = 'nakajijapan'
end

service = ApiBucket::Service::instance(:amazon)
res = service.search('ruby')

res.items.each do |item|
  p item.product_code
  p item.title
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
