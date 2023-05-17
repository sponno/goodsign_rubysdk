require_relative 'src/goodsign_api'
require_relative 'src/document'
require 'pp'
require 'dotenv'

Dotenv.load
@api_token = ENV['GOODSIGN_API_TOKEN']

api = GoodSignAPI.new(@api_token) 

# Lists all avaible templates in your account found on this page https://goodsign.io/dashboard?filter=template
# use api.get_document('uuid') to find all the details about a template 
response = api.list_templates()

pp response


