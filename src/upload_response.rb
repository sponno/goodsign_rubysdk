class UploadResponse
  attr_accessor :success, :doc, :warnings, :credit

  def initialize(attributes = {})
    @success = attributes['success']
    @doc = attributes['doc']
    @warnings = attributes['warnings']
    @credit = attributes['credit']
  end
end