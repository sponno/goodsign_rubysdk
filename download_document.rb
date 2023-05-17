require_relative 'src/goodsign_api'
require_relative 'src/document'
require 'pp'
require 'dotenv'

Dotenv.load
@api_token = ENV['GOODSIGN_API_TOKEN']

api = GoodSignAPI.new(@api_token) 


response = api.download_pdf('document_uuid','zip','download') #2nd argument can be "zip" or "pdf", folder is relative to this directory

pp response


