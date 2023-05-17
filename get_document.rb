require_relative 'src/goodsign_api'
require_relative 'src/document'
require 'pp'

require 'dotenv'
Dotenv.load
@api_token = ENV['GOODSIGN_API_TOKEN']


api = GoodSignAPI.new(@api_token) 


document = api.get_document('your_uuid') # returns status – see src/Document for attributes 


