require_relative 'src/goodsign_api'
require_relative 'src/document'
require 'pp'
require 'dotenv'

Dotenv.load
@api_token = ENV['GOODSIGN_API_TOKEN']

api = GoodSignAPI.new(@api_token) 

signers = [
  {
    key: 'signer1',
    name: 'John Ballinger',
    email: 'john@bluespark.co.nz',
    reminder_days: 1
  }
]

options = {
  metadata: {'any_valid_json':'any valid key'},
  webhook: '',
  cc_email: '',
  smsverify: false,
  send_in_order: false,
  email_subject: '{fullname} has requested your signature on {docname}',
  email_message: 'extra message to include, not required',
  ignore_missing_signers: false
}


response = api.upload_pdf('./goodsign_guide_v1.4.pdf', 'your_doc_name.pdf', signers, options)
pp response