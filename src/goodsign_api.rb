require 'net/http'
require 'json'
require 'uri'
require_relative 'document'
require_relative 'upload_response'

class GoodSignAPI
  attr_accessor :api_token

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

   def get_document(document_id)
    uri = URI("#{BASE_URL}/api/document/#{document_id}")

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


  def send_template(uuid, doc_name, signers, options = {})
    uri = URI("#{BASE_URL}/api/usetemplate")

    header = get_headers()

    body = {
      uuid: uuid,
      doc_name: doc_name,
      signers: signers
    }.merge(options)

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Post.new(uri.request_uri, header)
    request.body = body.to_json

    response = http.request(request)
    JSON.parse(response.body)
    json_response = JSON.parse(response.body)
    UploadResponse.new(json_response)
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
    #UploadResponse.new(json_response)
  end

  def void_document(uuid)
    uri = URI("#{BASE_URL}/api/document/#{uuid}/void")

    header = get_headers()

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Post.new(uri.request_uri, header)

    response = http.request(request)
    JSON.parse(response.body)
     JSON.parse(response.body)
    #UploadResponse.new(json_response)
  end

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

    # The response body will be the binary data of the PDF file.
    # You can write it to a file like this:
    File.open("#{download_folder}/#{document_id}.#{format}", 'wb') do |file|file.write(response.body)end
  end


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
    UploadResponse.new(json_response)
  end

end
