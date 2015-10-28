class DumpHtml
  attr_reader :destinations, :styles, :template, :layout
  def initialize
    @destinations = Destination.all
    @styles = Dir.glob(File.join(App.root, "/templates/css/*.css")).inject('') do |str, f|
      str += File.read(f)
    end
    @template = File.read(File.join(App.root, "/templates/html/main.html.erb"))
    @layout   = File.read(File.join(App.root, "/templates/html/layout.html.erb"))
  end
  def run(args)
    output_path = File.absolute_path(File.expand_path("#{args[:output]}"))
    destinations.each do |destination|
      opts = {
        template:     template,
        layout:       layout,
        styles:       styles,
        destination:  destination,
        output:       "#{output_path}/#{destination.link}",
        overview:     args[:overview] == "true"
      }
      HtmlGenerator.new(opts).perform
    end
    create_index "#{output_path}/index.html"
  end

  private
  def create_index(output_path)
    destinations = Destination.wihout_parent
    opts = {
      template:     File.read(File.join(App.root, "/templates/html/index.html.erb")),
      layout:       layout,
      styles:       styles,
      destinations: destinations,
      output:       output_path,
      overview:     false
    }
    HtmlGenerator.new(opts).perform
  end
end