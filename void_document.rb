require_relative 'src/goodsign_api'
require_relative 'src/document'
require 'pp'
require 'dotenv'

Dotenv.load
@api_token = ENV['GOODSIGN_API_TOKEN']

api = GoodSignAPI.new(@api_token) 

response = api.send_reminder('8e1fde01-a7d6-4f4c-b05b-ac026afefdff') #Single Doc - COMPLETE

puts response


