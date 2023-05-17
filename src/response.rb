class Response
  attr_accessor :success, :doc, :warnings, :credit

  def initialize(attributes = {})
    @success = attributes['success']
    @msg = attributes['msg']||attributes['message']||nil
    @doc = attributes['doc']
    @warnings = attributes['warnings']
    @credit = attributes['credit']
  end
end