require 'net/http'
require 'json'
require 'uri'
require_relative 'document'
require_relative 'response'

class GoodSignAPI
  attr_accessor :api_token

  # This if the for the USA Datacenter. Change this to BASE_URL = 'https://au.goodsign.io'.freeze for the AU datacenter
  BASE_URL = 'https://goodsign.io'.freeze

  def initialize(api_token)
    @api_token = api_token
  end

  def get_headers()
    return {
      'Content-Type': 'application/json',
      'Authorization': "Bearer #{@api_token}"
    }
  end

 # @param uuid [string] get all the deails of a document. see the Document object for all properties.
  def get_document(uuid)
    uri = URI("#{BASE_URL}/api/document/#{uuid}")

    header = get_headers()

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(uri.request_uri, header)

    response = http.request(request)
    json_response = JSON.parse(response.body)
    #puts json_response
    
    # @return [Document]
    Document.new(json_response['master_doc'],[])

  end

  # List all the existing templates in your account
  def list_templates
    uri = URI("#{BASE_URL}/api/templates")
    request = Net::HTTP::Get.new(uri)
    request['authorization'] = "Bearer #{@api_token}"

    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(request)
    end

    JSON.parse(response.body)
  end

  # Uploads a PDF with text tags and sends this document to signers. 
  # @param uuid - of a template you want to send, you can find this on the /templates page in the GoodSign API
  # @param doc_name - name of the new document to send.
  # @param signers [object] an array of signer objects, one or several signers
  # @param options [object] details about this document
  # @param fields [object] you can overwrite existing values of say text fields in the document, you simply need the key, value to change a field
  def send_template(uuid, doc_name, signers, options = {}, fields = {})
    uri = URI("#{BASE_URL}/api/usetemplate")

    header = get_headers()

    body = {
      uuid: uuid,
      doc_name: doc_name,
      signers: signers,
      fields: fields
    }.merge(options)

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Post.new(uri.request_uri, header)
    request.body = body.to_json

    response = http.request(request)
    JSON.parse(response.body)
    json_response = JSON.parse(response.body)
    #puts json_response
    Response.new(json_response)
  end

  def send_reminder(uuid)
    uri = URI("#{BASE_URL}/api/document/#{uuid}/remindall")

    header = get_headers()

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Post.new(uri.request_uri, header)

    response = http.request(request)
    JSON.parse(response.body)
    JSON.parse(response.body)
    #Response.new(json_response)
  end

  # Void a document - signers will be notified that a document is voided.
  # @param uuid - uuid of document

  def void_document(uuid)
    uri = URI("#{BASE_URL}/api/document/#{uuid}/void")

    header = get_headers()

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Post.new(uri.request_uri, header)

    response = http.request(request)
    JSON.parse(response.body)
  end

  # Download a completed template as PDF or Zip file (zip file is best when a signer has signed more than one PDF. )
  # @param UUID of document
  # @param format [string] pdf or zip
  # @param format [string] folder to put it in, eg 'download' will download file to ./download/filename.format(zip/pdf)

  def download_pdf(document_id,format = 'pdf', download_folder)
     unless ['pdf', 'zip'].include?(format)
        raise ArgumentError, "Invalid format: #{format}. Format must be 'pdf' or 'zip'."
     end

    endpoint = format == 'zip' ? 'downloadzip' : 'download'
    uri = URI("#{BASE_URL}/api/#{endpoint}/#{document_id}") 

    request = Net::HTTP::Get.new(uri)
    request['authorization'] = "Bearer #{@api_token}"
    request['Content-type'] = 'application/octet-stream'
    request['Content-Transfer-Encoding'] = 'binary' if format == 'zip'


    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    response = http.request(request)

    if response['Content-Type'] == 'application/json'
      # If the response is JSON, parse it and handle the error
      json_response = JSON.parse(response.body)
     # Handle the error based on the JSON response
    else

      # The response body will be the binary data of the PDF file.
      # You can write it to a file like this:
      File.open("#{download_folder}/#{document_id}.#{format}", 'wb') do |file|file.write(response.body)end
      OpenStruct.new(success:true, file:"#{download_folder}/#{document_id}.#{format}")
     end
        
  end

  # Uploads a PDF with text tags and sends this document to signers. 
  # @param file_path - location to file
  # @param doc_name - name of the new document to send.
  # @param signers [object] an array of signer objects, one or several signers
  # @param options [object] details about this document

  def upload_pdf(file_path, doc_name, signers, options = {})
    uri = URI("#{BASE_URL}/api/uploadpdf")

    header = get_headers()

    payload = {
      doc_name: doc_name,
      signers: signers
    }.merge(options)

    request = Net::HTTP::Post.new(uri.request_uri, header)
    request.set_form([
      ['file', File.open(file_path)],
      ['payload', payload.to_json]
    ], 'multipart/form-data')

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    response = http.request(request)
    json_response = JSON.parse(response.body)
    Response.new(json_response)
  end

end
