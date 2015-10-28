require 'erb'
require 'htmlentities'
class HtmlGenerator < Generator

  attr_reader :template, :layout, :output, :styles
  def initialize(attrs)
    super
    @template = attrs[:template]
    @layout   = attrs[:layout]
    @output   = attrs[:output]
    @styles   = attrs[:styles]
    @coder    = HTMLEntities.new
  end
  def perform
    save @output, render
  end

  def render
    templates = [@template, @layout]
    templates.inject(nil) do | prev, temp |
      _render(temp) { prev }
    end
  end

  def _render(temp)
    ERB.new(temp).result( binding )
  end

  def save(file, result)
    File.open(file, 'w') {|f| f.write result }
  end
end