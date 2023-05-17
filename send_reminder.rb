require_relative 'src/goodsign_api'
require_relative 'src/document'
require 'pp'
require 'dotenv'
Dotenv.load
@api_token = ENV['GOODSIGN_API_TOKEN']

api = GoodSignAPI.new(@api_token) 


response = api.void_document('1ef588e4-4437-41dd-91c9-c139992705d5') #Single Doc - COMPLETE

puts response


