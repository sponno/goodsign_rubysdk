require_relative 'src/goodsign_api'
require_relative 'src/document'
require 'pp'
require 'dotenv'

Dotenv.load
@api_token = ENV['GOODSIGN_API_TOKEN']

api = GoodSignAPI.new(@api_token) 

signers = [
  {
    key: 'signer',
    name: 'Jane_one Smith',
    email: 'john@bluespark.co.nz',
    reminder_days: 1
  }
]

options = {
  attachment_names_in_order: [],
  metadata: ['any valid json works'],
  webhook: '',
  cc_email: '',
  smsverify: false,
  send_in_order: false,
  duplicate: true,
  email_subject: '[fullname] has requested your signature on [docname]',
  email_message: '',
  ignore_missing_signers: false
}

response = api.send_template('6515e3a7-6e05-478a-85f4-ca76c60be848', 'Johns New Doc.pdf', signers, options)

pp response