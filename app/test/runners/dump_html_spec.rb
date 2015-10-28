require 'test_helper'

describe DumpHtml do
  before do
    @destinations = create_list :destination, 2
    @dhr = DumpHtml.new
  end

  it "should run" do
    @dhr.stub(:template, "<div><%= @destination.title %></div>") do |dhr1|
      dhr1.stub(:layout, "<html><body><%= yield %></body></html>") do |dhr2|
        dhr2.stub(:styles, "") do |_dhr|
          _dhr.template.must_be :==, "<div><%= @destination.title %></div>"
          _dhr.layout.must_be :==, "<html><body><%= yield %></body></html>"
          _dhr.styles.must_be :==, ""
          _dhr.destinations.count.must_be :==, 2
        end
      end
    end
  end

end