require 'nokogiri'
module NodeParser
  def self.topic_each_node(xml)
    reader = Nokogiri::XML::Reader(xml)
    reader.each do |node|
      if node.node_type == Nokogiri::XML::Reader::TYPE_ELEMENT && node.depth == 1
        destination_parser  = Nokogiri::XML::SAX::Parser.new(DestinationSaxParser.new)
        destination_parser.parse(node.inner_xml)
        yield node.name, destination_parser.document.entries
      end
    end
  end

  def self.destination_each_node(xml)
    reader = Nokogiri::XML::Reader(xml)
    reader.each do |node|
      if node.node_type == Nokogiri::XML::Reader::TYPE_ELEMENT && node.name == 'destination'
        attributes = {}
        node.attributes.sort.each do |name, value|
          attributes[name.gsub(/-/, '')] = value
        end
        yield attributes, node.outer_xml
      end
    end
  end

  def self.taxonomy_relation(node)
    return unless node.class == Nokogiri::XML::NodeSet || node.class == Nokogiri::XML::Element
    relations = node.children.inject([]) do |res, _node|
      result = taxonomy_relation(_node)
      res << result if result.class == Array && result.length > 0
      res << {parent: node.attr('atlas_node_id').to_s, child: _node.attr('atlas_node_id').to_s}
      res.flatten
    end || []
    relations.reject{|i| i[:child].empty? }
  end

end