# Yandex.XML parser
# Author: https://github.com/krdprog/ - Alexey Tsaplin-Kupaysinov
# License: MIT
require 'net/http'

# Get data from Yandex.XML service by XML - https://xml.yandex.ru/settings/
class YandexXml
  attr_accessor :keyword, :region

  def initialize(attributes = {})
    @user = attributes[:user]
    @key = attributes[:key]
    @region = attributes[:region]
  end

  # Get data from Yandex.XML service to XML format
  def to_xml
    create_xml_url

    @yandex_xml_to_xml = Net::HTTP.get_response(URI.parse(@xml_url)).body
  end

  private

  # Create URL for query from Yandex.XML by XML
  def create_xml_url
    base_url = 'https://yandex.ru/search/xml?'
    tail_url = '&groupby=attr%3Dd.mode%3Ddeep.groups-on-page%3D100.docs-in-group%3D1'
    query_url = URI.encode_www_form([['user', @user], ['key', @key], ['query', @keyword], ['lr', @region]])

    @xml_url = base_url + query_url + tail_url
  end
end
