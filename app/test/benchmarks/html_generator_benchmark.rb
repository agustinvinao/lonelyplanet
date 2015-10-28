require 'test_helper'

class HtmlGeneratorBenchmark < Minitest::Benchmark
  def bench_render
    @destination = Destination.new(title: 'test', atlas_id: '0001')
    @htmlgenerator = HtmlGenerator.new({
      destination: @destination,
      template: '<div><%= @destination.title %></div>',
      layout: '<html><body><%= yield %></body></html>',
      styles: '',
      output: ''
    })
    assert_performance_linear 0.009 do |n|
      @htmlgenerator.render
    end
  end
end