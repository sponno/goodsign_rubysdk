# GoodSign Ruby SDK

This is a Ruby SDK for the GoodSign API. It provides methods to interact with the API, such as sending a template, uploading a PDF, getting a document, and downloading a document.

## Installation

1. Clone this repository to your local machine.
2. Navigate to the project directory in your terminal.
3. Run `bundle install` to install the required gems.

## Usage

First, set your GoodSign API token as an environment variable in a `.env` file:

GOODSIGN_API_TOKEN=your_api_token


Then, you can use the SDK like this:

```ruby
require_relative 'src/goodsign_api'
require_relative 'src/document'
require 'pp'
require 'dotenv'

Dotenv.load
@api_token = ENV['GOODSIGN_API_TOKEN']

api = GoodSignAPI.new(@api_token) 

# Send a template
api.send_template(template_id, data)

# Upload a PDF
api.upload_pdf(file_path, payload)

# Get a document
document = api.get_document(document_id)

# Download a document
api.download_document(document_id, format, folder_relative_to_me)

```

## License

This project is licensed under the terms of the MIT license.
