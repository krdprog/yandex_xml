# gem 'yandex_xml'

Get data from Yandex.XML service by XML

**Yandex.XML service:** [https://xml.yandex.ru/settings/](https://xml.yandex.ru/settings/)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'yandex_xml'
```

And then execute:

```bash
$ bundle
```

Or install it yourself as:

```ruby
gem install yandex_xml
```

## Usage

**YandexXml has settings:** user, key, region, keyword

```ruby
require 'yandex_xml'

parse = YandexXml.new(user: 'your_yandex_login',
                      key: 'your_yandex_xml_key')

parse.region = '47'

# Single parsing
parse.keyword = 'пластиковые окна'
puts parse.to_xml
```

Real data for **your_yandex_login** and **your_yandex_xml_key** remove and add from page [https://xml.yandex.ru/settings/](https://xml.yandex.ru/settings/)

**Yandex regions:** see [https://tech.yandex.ru/xml/doc/dg/reference/regions-docpage/](https://tech.yandex.ru/xml/doc/dg/reference/regions-docpage/)