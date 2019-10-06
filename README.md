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

### Usage 1: Get data from Yandex.XML and create Hash with result

**Method:** get(keyword)

```ruby
require 'yandex_xml'

parser = YandexXml.new(user: 'your_yandex_login',
  key: 'your_yandex_xml_key',
  region: 'your_yandex_region')

p parser.get('ruby on rails')
# => Hash with data
```

**Results has data:**
- position,
- url,
- domain:,
- title,
- modtime,
- size,
- charset,
- passage, # TODO: not work
- passages_type,
- mime_type,
- saved_copy_url,
- headline,
- turbo_cgi_url,
- turbo_fallback,
- turbo_link

### Usage 2: Get 100 urls (Yandex Top-100) from result

**Method:** get_top100_urls(keyword)

```ruby
require 'yandex_xml'

parser = YandexXml.new(user: 'your_yandex_login',
  key: 'your_yandex_xml_key',
  region: 'your_yandex_region')

p parser.get_top100_urls('ruby')
# => Array with urls
```
**Results has data:**
Array with URLs

### Usage 3: Get position in Yandex Top-100 for site by keyword

**Method:** get_position(keyword, my_domain)

```ruby
require 'yandex_xml'

parser = YandexXml.new(user: 'your_yandex_login',
  key: 'your_yandex_xml_key',
  region: 'your_yandex_region')

p parser.get_position('ruby on rails', 'rusrails.ru')
# => String with position
```

**Results has data:**
String with position

Real data for **your_yandex_login** and **your_yandex_xml_key** remove and add from page [https://xml.yandex.ru/settings/](https://xml.yandex.ru/settings/)

**Yandex regions:** [https://tech.yandex.ru/xml/doc/dg/reference/regions-docpage/](https://tech.yandex.ru/xml/doc/dg/reference/regions-docpage/)