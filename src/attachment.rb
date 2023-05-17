class Attachment
  attr_accessor :name, :signers, :fields, :completed_time, :status, :cc, :is_attachment, :istemplate, :webhook, :metadata, :note, :uuid, :download_pdf, :download_zip

  def initialize(attributes = {})
    @name = attributes['name']
    @signers = attributes['signers']
    @fields = attributes['fields']
    @completed_time = attributes['completed_time']
    @status = attributes['status']
    @cc = attributes['cc']
    @is_attachment = attributes['is_attachment']
    @istemplate = attributes['istemplate']
    @webhook = attributes['webhook']
    @metadata = attributes['metadata']
    @note = attributes['note']
    @uuid = attributes['uuid']
    @download_pdf = attributes['download_pdf']
    @download_zip = attributes['download_zip']
  end
end
