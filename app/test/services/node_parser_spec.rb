require 'test_helper'

describe NodeParser do
  before do
    @taxonomy1 = %{<taxonomies><taxonomy><node atlas_node_id="355624" ethyl_content_object_id="" geo_id="355624"><node_name>The Drakensberg</node_name><node atlas_node_id="355625" ethyl_content_object_id="" geo_id="355625"><node_name>Royal Natal National Park</node_name></node></node></taxonomy></taxonomies>}
    @taxonomy2 = %{<taxonomies><taxonomy><node atlas_node_id="355619" ethyl_content_object_id="" geo_id="355619"><node_name>KwaZulu-Natal</node_name><node atlas_node_id="355620" ethyl_content_object_id="43725" geo_id="355620"><node_name>Durban</node_name></node><node atlas_node_id="355621" ethyl_content_object_id="1000576780" geo_id="355621"><node_name>Pietermaritzburg</node_name></node></node></taxonomy></taxonomies>}
    @taxonomy3 = %{<taxonomies><taxonomy><node atlas_node_id="355629" ethyl_content_object_id="3263" geo_id="355629"><node_name>Sudan</node_name><node atlas_node_id="355630" ethyl_content_object_id="" geo_id="355630"><node_name>Eastern Sudan</node_name><node atlas_node_id="355631" ethyl_content_object_id="" geo_id="355631"><node_name>Port Sudan</node_name></node></node><node atlas_node_id="355632" ethyl_content_object_id="" geo_id="355632">...</node></node></taxonomy></taxonomies>}
    @destination_node_xml = %{<destination atlas_id="355633" asset_id="1524-33" title="Swaziland" title-ascii="Swaziland"><history><history><history><![CDATA[test1]]></history><overview><![CDATA[test2]]></overview></history></history><introductory><introduction><overview><![CDATA[test3]]></overview></introduction></introductory></destination>}
    @destinations_xml = %{<destinations>#{@destination_node_xml}</destinations>}
  end

  it "return the destination attributes" do
    NodeParser.destination_each_node(@destinations_xml) do |attributes, xml|
      attributes.must_be_instance_of(Hash)
      xml.must_be :==, @destination_node_xml
    end
  end

  it "return the topic name and entries for the topic" do
    items = []
    NodeParser.topic_each_node(@destination_node_xml) do |topic_name, entries|
      items << {topic_name: topic_name, entries: entries}
    end
    items.first[:topic_name].must_be :==, 'history'
    items.last[:topic_name].must_be :==, 'introductory'
    items.first[:entries].length.must_be :==, 2
    items.last[:entries].length.must_be :==, 1
    items.first[:entries].first.is_overview.must_be :==, false
    items.last[:entries].last.is_overview.must_be :==, true
    items.first[:entries].first.title.must_be :==, 'history'
    items.last[:entries].last.title.must_be :==, 'overview'
  end

  it "return the relation between parent and children" do
    nodes1 = Nokogiri::XML(@taxonomy1).xpath('//taxonomies/taxonomy/node')
    nodes2 = Nokogiri::XML(@taxonomy2).xpath('//taxonomies/taxonomy/node')
    nodes3 = Nokogiri::XML(@taxonomy3).xpath('//taxonomies/taxonomy/node')
    NodeParser.taxonomy_relation(nodes1).must_be :==, [{parent: '355624', child: '355625'}]
    NodeParser.taxonomy_relation(nodes2).must_be :==, [{parent: "355619", child: "355620"}, {parent: "355619", child: "355621"}]
    NodeParser.taxonomy_relation(nodes3).must_be :==, [{parent: "355630", child: "355631"}, {parent: '355629', child: '355630'}, {parent: '355629', child: '355632'}]
  end

end