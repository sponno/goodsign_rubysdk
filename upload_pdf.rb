require_relative 'src/goodsign_api'
require_relative 'src/document'
require 'pp'
require 'dotenv'

Dotenv.load
@api_token = ENV['GOODSIGN_API_TOKEN']

api = GoodSignAPI.new(@api_token) 


# The key for this signer is "signer1", you will find refences to signer1 in the PDF file. 
# Text fields have been added to the PDF to indicate which signer should sign where 
# eg in the PDF file you will find [ sign | signer1 ] or [name | signer1 ] 
signers = [
  {
    key: 'signer1',
    name: 'John Ballinger',
    email: 'john@bluespark.co.nz',
    reminder_days: 1
  }
]

# NOTE fields starting with "x_" are optional. To use these fields, remove the "x_"
# If send_in_order is true, signers will be requested to sign in the order that they 
# apear in the above json.
options = {
  x_metadata: {'any_valid_json':'any valid key'},
  x_webhook: '',
  cc_email: '',
  smsverify: false,
  send_in_order: false,
  x_email_subject: '{fullname} has requested your signature on {docname}',
  x_email_message: 'extra message to include, not required',
  ignore_missing_signers: false
}


response = api.upload_pdf('./goodsign_guide_v1.4.pdf', 'your_doc_name.pdf', signers, options)
pp response