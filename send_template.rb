require_relative 'src/goodsign_api'
require_relative 'src/document'
require 'pp'
require 'dotenv'

Dotenv.load
@api_token = ENV['GOODSIGN_API_TOKEN']

api = GoodSignAPI.new(@api_token) 

# List of signer
# key is the key from the template
# name and email are required, email must be valid
# reminder_days = how many days to wait between each reminder (1 day = send a reminder every day, 2 days = remind every second day, 0 =  no reminders), reminders stop after 5 reminders


signers = [
  {
    key: 'signer1',
    name: 'John Smith',
    email: 'test@example.com',
    reminder_days: 1
  }
]

# Fields are optional - you can use this to overdie the values in a document. 
# To find 'key' for a field. Open the template, in the designer view, when you select 
# an item on the page, a small grey label will appear bottom right with the key for the selected field. 
# ** If you have added a field the key wont appear until you save the document ** 

fields = [
  {
    key: 'bcb18c95-1159-4ca2-b189-197eaf3477a7',
    value: 'From Ruby'
  }
]


# Document options
# ignore_missing_signers (if set to true, will remove any extra signers found on the document, eg you could have 3 signers on the document, but if you only send 1 signer, the other 2 will be deleted)
# webhook = a URL to your webhook. You will receive several events about the documents status, you may also recieve more than one event when the document is complete. 
# smsverify = true/false, if you want the signer to verify their identity using a SMS to their mobile phone. 
# Duplicate = true - this means we will create a copy of the template, if you set it to false, it will actually use the template and the template will no longer exist
# metadata = any valid json object, can be an array, or object keys and values - stored a JSON string in goodsign. 

options = {
  metadata: ['any valid json works'],
  webhook: '',
  cc_email: '',
  smsverify: false,
  send_in_order: false,
  duplicate: true,
  x_email_subject: 'John has requested your signature on name of your document',
  x_email_message: '',
  ignore_missing_signers: false
}

response = api.send_template('c89dde31-3ff5-4f86-a842-06b856050ed0', 'New Doc from Ruby SDK.pdf', signers, options, fields)

pp response