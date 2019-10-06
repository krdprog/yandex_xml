# Yandex.XML parser - version 1.0.1 (gem yandex_xml)
# Author: https://github.com/krdprog/ - Alexey Tsaplin-Kupaysinov
# License: MIT
require 'net/http'
require 'json'
require 'nori'

# Get data from Yandex.XML service by XML - https://xml.yandex.ru/settings/
# Yandex.XML Doc: https://yandex.ru/dev/xml/doc/dg/concepts/response-docpage/
# Yandex Regions: https://yandex.ru/dev/xml/doc/dg/reference/regions-docpage/
class YandexXml
  def initialize(args)
    @user = args[:user]
    @key = args[:key]
    @region = args.fetch(:region, '213') # Moscow
  end

  # Get data from Yandex.XML and create Hash with result
  def get(keyword)
    # Create URL to Yandex.Xml
    xml_url = create_url(keyword)
    # Get data XML
    xml = Net::HTTP.get_response(URI.parse(xml_url)).body
    # Convert XML to Hash
    converter = Nori.new(:convert_dashes_to_underscores => true)
    hash = converter.parse(xml)
    # Convert Hash to OpenStruct
    data = JSON.parse(hash.to_json, object_class: OpenStruct)
    # Create short route to data
    groups = data.yandexsearch.response.results.grouping.group

    result = {}

    result[:meta] = {
      keyword: data.yandexsearch.request.query,
      timestamp: Time.now
    }

    data_array = []

    groups.each_with_index do |i, index|
      result_hash = {
        position: index + 1,
        url: i.doc.url,
        domain: i.doc.domain,
        title: i.doc.title,
        modtime: i.doc.modtime,
        size: i.doc.size,
        charset: i.doc.charset,
        # passage: i.doc.passages.passage, # TODO: not work
        passages_type: i.doc.properties._PassagesType,
        mime_type: i.doc.mime_type,
        saved_copy_url: i.doc.saved_copy_url,
        headline: i.doc.headline,
        turbo_cgi_url: i.doc.properties.TurboCgiUrl,
        turbo_fallback: i.doc.properties.TurboFallback,
        turbo_link: i.doc.properties.TurboLink
      }

      data_array << result_hash
    end

    result[:data] = data_array
    result
  end

  # Get 100 urls (Yandex Top-100) from result
  def get_top100_urls(keyword)
    hash = get(keyword)
    struct = JSON.parse(hash.to_json, object_class: OpenStruct)

    urls = []
    struct.data.each { |i| urls << i.url }
    urls
  end

  # Get position in Yandex Top-100 for site by keyword
  def get_position(keyword, my_domain)
    hash = get(keyword)
    struct = JSON.parse(hash.to_json, object_class: OpenStruct)

    domains = []
    struct.data.each { |i| domains << i.domain.downcase }

    position = 0
    domains.each_with_index do |domain, i|
      position = i + 1 if domain == my_domain
    end

    position
  end

  # TODO: Get information about limits in Yandex.XML service.
  def get_limits
    # code
  end

  private

  # Create URL for query from Yandex.XML by XML
  def create_url(keyword)
    base_url = 'https://yandex.ru/search/xml?'
    tail_url = '&groupby=attr%3Dd.mode%3Ddeep.groups-on-page%3D100.docs-in-group%3D1'
    query_url = URI.encode_www_form([['user', @user], ['key', @key], ['query', keyword], ['lr', @region]])

    base_url + query_url + tail_url
  end
end
