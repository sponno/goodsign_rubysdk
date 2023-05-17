require_relative 'src/goodsign_api'
require_relative 'src/document'
require 'pp'

require 'dotenv'
Dotenv.load
@api_token = ENV['GOODSIGN_API_TOKEN']


api = GoodSignAPI.new(@api_token) 


#d = api.get_document('5c72a88f-e25f-4f37-a976-3fd3cc695c4c') # Document with attachments document
#d = api.get_document('43b7f014-34d4-415f-9d18-ed0e4f0e0cae')  #Single Doc - UNCOMPLETE

document = api.get_document('54c0e3e4-f225-46e3-aaaa-d1424e475fc7') #Single Doc - COMPLETE


