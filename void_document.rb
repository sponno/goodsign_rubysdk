require_relative 'src/goodsign_api'
require_relative 'src/document'
require 'pp'
require 'dotenv'

Dotenv.load
@api_token = ENV['GOODSIGN_API_TOKEN']

api = GoodSignAPI.new(@api_token) 

response = api.send_reminder('f2a7aa2b-83e3-4bc8-a270-4b4f767b8af1') #Single Doc - COMPLETE

puts response


