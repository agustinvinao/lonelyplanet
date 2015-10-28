class DestinationSaxParser < Nokogiri::XML::SAX::Document
  attr_reader :entries, :entry_name, :entry_content, :depth
  def initialize
    @entries  = []
    @depth    = 0
  end
  def start_document
    @entry_name     = ''
    @entry_content  = ''
  end
  def start_element(name, attrs = [])
    @depth += 1
    @entry_name = name
  end
  def cdata_block(string)
    @entry_content = string
  end
  def end_element(name)
    # if(@entry_name == name)
      entry = Entry.new(
        title:        @entry_name,
        cdata:        @entry_content,
        is_overview:  name == 'overview'
      )
      @entries << entry if @depth > 1
    # end
    @depth -= 1
  end
end