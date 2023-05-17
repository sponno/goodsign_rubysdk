require_relative 'src/goodsign_api'
require_relative 'src/document'
require 'pp'
require 'dotenv'

Dotenv.load
@api_token = ENV['GOODSIGN_API_TOKEN']

api = GoodSignAPI.new(@api_token) 


response = api.download_pdf('54c0e3e4-f225-46e3-aaaa-d1424e475fc7','zip','download') #Single Doc - COMPLETE

puts response


