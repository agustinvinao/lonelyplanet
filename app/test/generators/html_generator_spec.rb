require 'test_helper'

describe HtmlGenerator do
  before do
    @destination = create :destination
    @htmlgenerator = HtmlGenerator.new({
      destination: @destination,
      template: '<div><%= @destination.title %></div>',
      layout: '<html><body><%= yield %></body></html>',
      styles: '',
      output: ''
    })
  end

  it 'render destination content' do
    @htmlgenerator.destination.must_be :==, @destination
    @htmlgenerator.render.must_be :==, "<html><body><div>#{@destination.title}</div></body></html>"
    @htmlgenerator.must_respond_to(:perform)
  end

end